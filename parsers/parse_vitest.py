#!/usr/bin/env python3
"""Parse Vitest bench JSON or text output into unified CSV."""

import json
import os
import re
import sys

VM_NAME = "blaze-jsc"  # default; overridden by CLI arg
HEADER = "vm,script,mean_ns,median_ns,min_ns,max_ns,stddev_ns,iterations"

# Strip ANSI escape codes
ANSI_RE = re.compile(r"\x1b\[[0-9;]*m")

# Vitest bench table row (v4.x default reporter):
#    · auction_1-1   1,849.66  0.4437  1.0553  0.5406  0.5325  0.9572  1.0099  1.0553  ±1.38%  926
# Columns: name, hz, min, max, mean, p75, p99, p995, p999, rme, samples
# Time values are in milliseconds.
TABLE_RE = re.compile(
    r"^\s*[·✓]\s+"                       # marker (· or ✓)
    r"(\S+)\s+"                          # name
    r"[\d,.]+\s+"                        # hz (ignored)
    r"([\d.]+)\s+"                       # min (ms)
    r"([\d.]+)\s+"                       # max (ms)
    r"([\d.]+)\s+"                       # mean (ms)
    r"[\d.]+\s+"                         # p75 (ignored)
    r"[\d.]+\s+"                         # p99 (ignored)
    r"[\d.]+\s+"                         # p995 (ignored)
    r"[\d.]+\s+"                         # p999 (ignored)
    r"[±+-]?([\d.]+)%\s+"               # rme%
    r"(\d+)",                            # samples
    re.MULTILINE,
)


def parse_json(json_path: str) -> None:
    """Parse Vitest bench JSON reporter output."""
    print(HEADER)

    with open(json_path) as f:
        data = json.load(f)

    test_results = data.get("testResults", [])
    for suite in test_results:
        for result in suite.get("assertionResults", []):
            bench = result.get("benchmarkResult")
            if not bench:
                continue

            name = result.get("ancestorTitles", [""])[-1] if result.get(
                "ancestorTitles"
            ) else result.get("fullName", "unknown")
            name = result.get("title", name)

            mean_s = bench.get("mean", 0)
            min_s = bench.get("min", 0)
            max_s = bench.get("max", 0)
            samples = bench.get("samples", 0)

            mean_ns = int(mean_s * 1e9)
            min_ns = int(min_s * 1e9)
            max_ns = int(max_s * 1e9)

            rme = bench.get("rme", 0)
            stddev_ns = int(mean_ns * rme / 100) if rme else 0

            median_ns = int(bench.get("p50", mean_s) * 1e9)

            print(
                f"{VM_NAME},{name},"
                f"{mean_ns},{median_ns},{min_ns},{max_ns},"
                f"{stddev_ns},{samples}"
            )


def parse_text(log_path: str) -> None:
    """Parse Vitest bench default text output (table format)."""
    print(HEADER)

    with open(log_path) as f:
        content = f.read()

    # Strip ANSI escape codes
    content = ANSI_RE.sub("", content)

    for m in TABLE_RE.finditer(content):
        name = m.group(1)
        min_ms = float(m.group(2))
        max_ms = float(m.group(3))
        mean_ms = float(m.group(4))
        rme_pct = float(m.group(5))
        iterations = int(m.group(6))

        mean_ns = int(mean_ms * 1_000_000)
        min_ns = int(min_ms * 1_000_000)
        max_ns = int(max_ms * 1_000_000)
        median_ns = mean_ns  # table doesn't show median separately
        stddev_ns = int(mean_ns * rme_pct / 100)

        print(
            f"{VM_NAME},{name},"
            f"{mean_ns},{median_ns},{min_ns},{max_ns},"
            f"{stddev_ns},{iterations}"
        )


if __name__ == "__main__":
    if len(sys.argv) < 3:
        print(f"Usage: {sys.argv[0]} <vm-name> <log-file>", file=sys.stderr)
        sys.exit(1)

    VM_NAME = sys.argv[1]
    log_path = sys.argv[2]
    json_path = log_path.replace("-raw.log", "-raw.json")

    if os.path.isfile(json_path) and os.path.getsize(json_path) > 0:
        parse_json(json_path)
    elif os.path.isfile(log_path):
        parse_text(log_path)
    else:
        print(HEADER)
        print(f"Warning: no {VM_NAME} output found", file=sys.stderr)
