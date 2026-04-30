#!/usr/bin/env python3
"""Generate markdown and HTML comparison reports from unified.csv."""

import csv
import math
import os
import sys
from collections import defaultdict

VM_ORDER = [
    "haskell", "scalus-jit", "scalus-cek",
    "julc-java",
    "llvm-uplc-jit",
    "uplc-turbo-bc", "uplc-turbo",
    "plutuz", "chrysalis", "chrysalis-aot",
    "plutigo", "blaze-jsc", "blaze-v8", "opshin",
]
VM_LABELS = {
    "uplc-turbo": "uplc-turbo AST walker (Rust)",
    "uplc-turbo-bc": "uplc-turbo Bytecode VM (Rust)",
    "plutuz": "Plutuz CEK (Zig)",
    "chrysalis": "Chrysalis CEK (C# / .NET)",
    "chrysalis-aot": "Chrysalis CEK (C# / .NET AOT)",
    "plutigo": "Plutigo CEK (Go)",
    "blaze-jsc": "blaze-plutus CEK (TypeScript / Bun JSC)",
    "blaze-v8": "blaze-plutus CEK (TypeScript / Node V8)",
    "opshin": "opshin CEK (Python / CPython)",
    "haskell": "plutus-core CEK (Haskell / GHC)",
    "scalus-cek": "Scalus CEK (Scala / JVM)",
    "scalus-jit": "Scalus UPLC→JVM JIT (Scala / JVM)",
    "julc-java": "Julc CEK (Java / GraalVM)",
    "llvm-uplc-jit": "llvm-uplc UPLC→native JIT (C++ / LLVM)",
}


def fmt_ns(ns: int) -> str:
    """Format nanoseconds into human-readable string."""
    if ns >= 1_000_000_000:
        return f"{ns / 1e9:.2f} s"
    if ns >= 1_000_000:
        return f"{ns / 1e6:.2f} ms"
    if ns >= 1_000:
        return f"{ns / 1e3:.2f} us"
    return f"{ns} ns"


def geometric_mean(values: list[float]) -> float:
    """Compute geometric mean of positive values."""
    if not values:
        return 0
    log_sum = sum(math.log(v) for v in values if v > 0)
    return math.exp(log_sum / len(values))


def load_data(run_dir: str):
    """Load unified.csv and return (data, scripts, present_vms, env_info)."""
    unified_path = os.path.join(run_dir, "unified.csv")
    if not os.path.isfile(unified_path):
        print("Error: unified.csv not found", file=sys.stderr)
        sys.exit(1)

    data: dict[str, dict[str, int]] = defaultdict(dict)
    with open(unified_path) as f:
        for row in csv.DictReader(f):
            vm = row["vm"]
            script = row["script"]
            mean_ns = int(row["mean_ns"])
            data[script][vm] = mean_ns

    scripts = sorted(data.keys())
    present_vms = [vm for vm in VM_ORDER if any(vm in data[s] for s in scripts)]

    env_path = os.path.join(run_dir, "environment.txt")
    env_info = ""
    if os.path.isfile(env_path):
        with open(env_path) as f:
            env_info = f.read().strip()

    return data, scripts, present_vms, env_info


def compute_geo_means(data, scripts, present_vms):
    """Compute geometric means with penalty for missing scripts.

    When a VM hasn't implemented a benchmark script, it gets assigned
    the score of the slowest competitor on that script. This prevents
    VMs from gaming the leaderboard by selectively skipping slow tests.
    """
    geo_means: dict[str, float] = {}

    for vm in present_vms:
        values = []
        for s in scripts:
            t = data[s].get(vm, 0)
            if t > 0:
                values.append(t)
            else:
                # Missing or failed: assign the slowest successful time
                # from any other VM on this script
                worst = max(
                    (data[s].get(other_vm, 0) for other_vm in present_vms if other_vm != vm),
                    default=0,
                )
                if worst > 0:
                    values.append(worst)
                # If no VM has a result for this script, skip it entirely

        geo_means[vm] = geometric_mean(values)

    return geo_means


def generate_markdown(run_dir: str, data, scripts, present_vms, env_info) -> None:
    """Generate report.md."""
    geo_means = compute_geo_means(data, scripts, present_vms)

    fastest_geo = min(geo_means.values()) if geo_means else 1

    lines = []
    lines.append("# Cardano Plutus VM Benchmark Results")
    lines.append("")
    date = os.path.basename(run_dir)
    lines.append(f"**Date:** {date}")
    lines.append("")

    if env_info:
        lines.append("## Environment")
        lines.append("```")
        lines.append(env_info)
        lines.append("```")
        lines.append("")

    lines.append("## Summary (geometric mean across all scripts)")
    lines.append("")
    lines.append("*Note: VMs that fail or skip a script are assigned the slowest competitor's time for that script.*")
    lines.append("")
    lines.append("| VM | Language | Geo Mean | vs Fastest |")
    lines.append("|---|---|---|---|")

    sorted_vms = sorted(present_vms, key=lambda vm: geo_means.get(vm, float("inf")))
    for vm in sorted_vms:
        label = VM_LABELS.get(vm, vm)
        lang = label.split("(")[-1].rstrip(")") if "(" in label else ""
        geo = geo_means[vm]
        ratio = geo / fastest_geo if fastest_geo > 0 else 0
        lines.append(f"| **{label}** | {lang} | {fmt_ns(int(geo))} | {ratio:.2f}x |")

    # Count scripts per VM
    lines.append("")
    lines.append("### Script Coverage")
    lines.append("")
    lines.append("| VM | Passed | Failed | Missing | Total |")
    lines.append("|---|---|---|---|---|")
    for vm in sorted_vms:
        success = sum(1 for s in scripts if data[s].get(vm, 0) > 0)
        fail = sum(1 for s in scripts if data[s].get(vm, 0) < 0)
        missing = len(scripts) - success - fail
        lines.append(f"| {VM_LABELS.get(vm, vm)} | {success} | {fail} | {missing} | {len(scripts)} |")

    lines.append("")

    lines.append("## Per-Script Results")
    lines.append("")
    header = "| Script |" + "|".join(f" {VM_LABELS.get(vm, vm)} " for vm in present_vms) + "|"
    separator = "|---|" + "|".join("---" for _ in present_vms) + "|"
    lines.append(header)
    lines.append(separator)

    for script in scripts:
        row = f"| {script} |"
        script_times = {vm: data[script].get(vm, 0) for vm in present_vms}
        fastest = min((t for t in script_times.values() if t > 0), default=0)

        for vm in present_vms:
            t = script_times[vm]
            if t > 0:
                cell = fmt_ns(t)
                if t == fastest and len([v for v in script_times.values() if v > 0]) > 1:
                    cell = f"**{cell}**"
                row += f" {cell} |"
            elif t < 0:
                row += " FAIL |"
            else:
                row += " - |"
        lines.append(row)

    lines.append("")
    lines.append("---")
    lines.append("*Generated by [cardano-plutus-vm-benchmark](https://github.com/saib-inc/cardano-plutus-vm-benchmark)*")

    report = "\n".join(lines)
    report_path = os.path.join(run_dir, "report.md")
    with open(report_path, "w") as f:
        f.write(report)

    print(report)
    print(f"\nReport saved to: {report_path}", file=sys.stderr)


def generate_html(run_dir: str, env_info: str) -> None:
    """Generate docs/index.html from template + unified.csv data."""
    unified_path = os.path.join(run_dir, "unified.csv")
    template_path = os.path.join(os.path.dirname(__file__), "template.html")

    if not os.path.isfile(template_path):
        print("Warning: report/template.html not found, skipping HTML generation", file=sys.stderr)
        return

    with open(template_path) as f:
        template = f.read()

    with open(unified_path) as f:
        csv_data = f.read().strip()

    # Build environment badge
    if env_info:
        env_badge = ""
        for line in env_info.split("\n"):
            line = line.strip()
            if line.startswith("CPU:"):
                env_badge += f"<code>{line.split(':', 1)[1].strip()}</code>"
            elif line.startswith("Cores:"):
                env_badge += f" &middot; {line.split(':', 1)[1].strip()} cores"
            elif line.startswith("RAM:"):
                env_badge += f" &middot; {line.split(':', 1)[1].strip()}"
            elif line.startswith("OS:"):
                env_badge += f" &middot; {line.split(':', 1)[1].strip()}"
        date = os.path.basename(run_dir)
        env_badge += f" &middot; {date}"
    else:
        env_badge = os.path.basename(run_dir)

    html = template.replace("{{CSV_DATA}}", csv_data).replace("{{ENV_BADGE}}", env_badge)

    # Write to docs/index.html (relative to repo root)
    repo_root = os.path.dirname(os.path.dirname(__file__))
    docs_dir = os.path.join(repo_root, "docs")
    os.makedirs(docs_dir, exist_ok=True)
    html_path = os.path.join(docs_dir, "index.html")
    with open(html_path, "w") as f:
        f.write(html)

    print(f"HTML report saved to: {html_path}", file=sys.stderr)


def generate(run_dir: str) -> None:
    data, scripts, present_vms, env_info = load_data(run_dir)
    generate_markdown(run_dir, data, scripts, present_vms, env_info)
    generate_html(run_dir, env_info)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <run-dir>", file=sys.stderr)
        sys.exit(1)
    generate(sys.argv[1])
