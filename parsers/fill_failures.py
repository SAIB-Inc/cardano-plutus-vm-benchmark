#!/usr/bin/env python3
"""Fill in -1 rows for scripts that a VM failed or produced no results for.

Usage: fill_failures.py <vm-csv> <data-dir> <vm-name> [raw-log]

Compares the scripts in <data-dir> (*.flat files) against the results in <vm-csv>.
Any script present in the data dir but missing from the CSV is appended as a
failure row with -1 timings.

If a raw log file is provided, it is scanned for common error signals
mentioning script names. Scripts that appear in error contexts have their
results overridden to -1, even if the benchmark framework reported a
valid-looking timing.
"""

import csv
import os
import re
import sys

# Patterns that indicate an error occurred, grouped by what frameworks emit.
ERROR_PATTERNS = [
    # JVM / JMH (Scalus)
    r"<failure>",
    r"java\.\S+Exception",
    r"scala\.\S+Exception",
    r"Caused by:",
    # .NET (Chrysalis)
    r"Unhandled exception",
    r"System\.\S+Exception",
    # Go (Plutigo)
    r"^panic:",
    r"^goroutine\s+\d+",
    # Zig (Plutuz)
    r"panic\{",
    # Python (opshin)
    r"^Traceback ",
    r"SKIP \(eval error\)",
    # Rust (uplc-turbo)
    r"^EVAL_FAIL:",
    r"thread '.*' panicked",
    # Node.js / Bun (blaze)
    r"^TypeError:",
    r"^RangeError:",
    r"^ReferenceError:",
    # Haskell
    r"\bException:",
]

ERROR_RE = re.compile("|".join(f"(?:{p})" for p in ERROR_PATTERNS), re.MULTILINE)

# Patterns that associate a script name with a benchmark context.
# These help us find which script an error belongs to by scanning backwards
# from an error line to find the most recent script reference.
SCRIPT_CONTEXT_PATTERNS = [
    # Criterion (Rust): "Benchmarking script-name"
    r"^Benchmarking\s+(\S+)",
    # JMH (Scalus): "# Parameters: (file = script-name.flat)"
    r"# Parameters:.*file\s*=\s*(\S+?)(?:\.flat)?\)",
    # uplc-turbo: "EVAL_FAIL: script-name"
    r"^EVAL_FAIL:\s+(\S+)",
    # opshin: "script-name SKIP (eval error)"
    r"^(\S+)\s+SKIP \(eval error\)",
    # Generic: script name appears on the error line itself
]

CONTEXT_RE = re.compile("|".join(SCRIPT_CONTEXT_PATTERNS), re.MULTILINE)


def scan_log_for_failures(log_path: str, script_names: set[str]) -> set[str]:
    """Scan a raw log for error signals and associate them with script names.

    Uses a "most recent context" approach: scans lines sequentially, tracking
    which script is currently being benchmarked. When an error line is found,
    the current script (if any) is marked as failed.
    """
    if not os.path.isfile(log_path):
        return set()

    with open(log_path, errors="replace") as f:
        lines = f.readlines()

    failed = set()
    current_script = None

    for line in lines:
        # Check if this line establishes a script context
        m = CONTEXT_RE.search(line)
        if m:
            # Extract the matched script name from whichever group matched
            name = next((g for g in m.groups() if g is not None), None)
            if name:
                # Strip .flat suffix if present
                name = name.replace(".flat", "")
                if name in script_names:
                    current_script = name

        # Check if this line contains an error signal
        if ERROR_RE.search(line):
            if current_script:
                failed.add(current_script)
            # Also check if any script name appears directly on the error line
            for script in script_names:
                if script in line:
                    failed.add(script)

    return failed


def fill_failures(
    csv_path: str, data_dir: str, vm_name: str, log_path: str | None = None
) -> None:
    # Get all expected scripts from data dir
    expected = set()
    for f in os.listdir(data_dir):
        if f.endswith(".flat"):
            expected.add(f.replace(".flat", ""))

    # Read existing CSV rows
    rows = []
    present = set()
    header_line = "vm,script,mean_ns,median_ns,min_ns,max_ns,stddev_ns,iterations\n"
    if os.path.isfile(csv_path):
        with open(csv_path) as f:
            header_line = f.readline()
        with open(csv_path) as f:
            for row in csv.DictReader(f):
                rows.append(row)
                present.add(row["script"])

    # Scan log for error signals if provided
    log_failures = set()
    if log_path:
        log_failures = scan_log_for_failures(log_path, expected)
        # Override any existing results for scripts that appeared in error context
        errored_with_results = log_failures & present
        if errored_with_results:
            rows = [r for r in rows if r["script"] not in errored_with_results]
            print(
                f"  {vm_name}: {len(errored_with_results)} results overridden "
                f"(error signals in log): {', '.join(sorted(errored_with_results))}",
                file=sys.stderr,
            )

    # All scripts that need -1 entries: missing from CSV or detected as failed
    all_failures = (expected - present) | log_failures

    if not all_failures and not log_failures:
        return

    new_failures = sorted(all_failures - present)

    # Rewrite CSV: keep good rows, append failure rows
    fields = header_line.strip().split(",")
    with open(csv_path, "w") as f:
        f.write(header_line)
        for row in rows:
            f.write(",".join(row.get(k, "") for k in fields) + "\n")
        for script in sorted(all_failures):
            f.write(f"{vm_name},{script},-1,-1,-1,-1,-1,0\n")

    if new_failures:
        print(
            f"  {vm_name}: {len(new_failures)} scripts failed (no result)",
            file=sys.stderr,
        )


if __name__ == "__main__":
    if len(sys.argv) < 4:
        print(
            f"Usage: {sys.argv[0]} <vm-csv> <data-dir> <vm-name> [raw-log]",
            file=sys.stderr,
        )
        sys.exit(1)
    log = sys.argv[4] if len(sys.argv) > 4 else None
    fill_failures(sys.argv[1], sys.argv[2], sys.argv[3], log)
