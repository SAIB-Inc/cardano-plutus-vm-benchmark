#!/usr/bin/env python3
"""Parse BenchmarkDotNet JSON benchmark output into unified CSV."""

import json
import os
import sys

VM_NAME = "chrysalis"  # default; overridden by CLI arg
HEADER = "vm,script,mean_ns,median_ns,min_ns,max_ns,stddev_ns,iterations"

# BenchmarkDotNet reports times with unit suffixes
UNIT_MULTIPLIERS = {
    "ns": 1,
    "us": 1_000,
    "\u03bcs": 1_000,  # mu-s unicode
    "ms": 1_000_000,
    "s": 1_000_000_000,
}


def parse_time_ns(value) -> int:
    """Convert a BDN time value to nanoseconds."""
    if isinstance(value, (int, float)):
        return int(value)
    # String with unit suffix
    s = str(value).strip()
    for unit, mult in UNIT_MULTIPLIERS.items():
        if s.endswith(unit):
            return int(float(s[: -len(unit)].strip()) * mult)
    return int(float(s))


def parse(run_dir: str) -> None:
    print(HEADER)

    # Find BDN JSON report files
    json_files = []
    for root, _, files in os.walk(run_dir):
        for f in files:
            if f.endswith(".json") and "PlutusUseCases" in f:
                json_files.append(os.path.join(root, f))

    if not json_files:
        # Try the standard BDN output path
        artifacts_dir = os.path.join(run_dir)
        for root, _, files in os.walk(artifacts_dir):
            for f in files:
                if f.endswith("-report.json"):
                    json_files.append(os.path.join(root, f))

    for json_file in json_files:
        with open(json_file) as f:
            data = json.load(f)

        benchmarks = data.get("Benchmarks", [])
        for bench in benchmarks:
            # Extract script name from parameters
            params = bench.get("Parameters", "")
            script_name = params.replace("Script=", "") if params else bench.get(
                "MethodTitle", "unknown"
            )

            stats = bench.get("Statistics", {})
            mean_ns = parse_time_ns(stats.get("Mean", 0))
            median_ns = parse_time_ns(stats.get("Median", 0))
            min_ns = parse_time_ns(stats.get("Min", 0))
            max_ns = parse_time_ns(stats.get("Max", 0))
            stddev_ns = parse_time_ns(stats.get("StandardDeviation", 0))
            iterations = stats.get("N", 0)

            print(
                f"{VM_NAME},{script_name},"
                f"{mean_ns},{median_ns},{min_ns},{max_ns},"
                f"{stddev_ns},{iterations}"
            )


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(f"Usage: {sys.argv[0]} [vm-name] <run-dir>", file=sys.stderr)
        sys.exit(1)
    if len(sys.argv) == 3:
        VM_NAME = sys.argv[1]
        parse(sys.argv[2])
    else:
        parse(sys.argv[1])
