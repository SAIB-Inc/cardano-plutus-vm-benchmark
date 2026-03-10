#!/usr/bin/env python3
"""Merge per-VM CSV files into a single unified.csv."""

import csv
import os
import sys

VM_FILES = [
    "chrysalis.csv",
    "chrysalis-aot.csv",
    "uplc-turbo.csv",
    "plutigo.csv",
    "blaze-jsc.csv",
    "blaze-v8.csv",
    "plutuz.csv",
    "opshin.csv",
]

HEADER = ["vm", "script", "mean_ns", "median_ns", "min_ns", "max_ns", "stddev_ns", "iterations"]


def normalize(run_dir: str) -> None:
    output_path = os.path.join(run_dir, "unified.csv")
    rows = []

    for vm_file in VM_FILES:
        path = os.path.join(run_dir, vm_file)
        if not os.path.isfile(path):
            print(f"  skip: {vm_file} (not found)", file=sys.stderr)
            continue

        with open(path) as f:
            reader = csv.DictReader(f)
            count = 0
            for row in reader:
                rows.append(row)
                count += 1
            print(f"  loaded: {vm_file} ({count} scripts)", file=sys.stderr)

    # Sort by script name, then VM name
    rows.sort(key=lambda r: (r.get("script", ""), r.get("vm", "")))

    with open(output_path, "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=HEADER)
        writer.writeheader()
        writer.writerows(rows)

    print(f"  wrote: {output_path} ({len(rows)} total rows)", file=sys.stderr)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <run-dir>", file=sys.stderr)
        sys.exit(1)
    normalize(sys.argv[1])
