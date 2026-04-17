#!/usr/bin/env python3
"""Parse llvm-uplc (uplcbench) JSON benchmark output into unified CSV."""

import json
import sys

VM_NAME = "llvm-uplc-jit"
HEADER = "vm,script,mean_ns,median_ns,min_ns,max_ns,stddev_ns,iterations"


def parse(json_path: str) -> None:
    print(HEADER)

    with open(json_path) as f:
        data = json.load(f)

    for bench in data.get("benchmarks", []):
        name = bench["name"]
        print(
            f"{VM_NAME},{name},"
            f"{bench['mean_ns']},"
            f"{bench['median_ns']},"
            f"{bench['min_ns']},"
            f"{bench['max_ns']},"
            f"{bench['stddev_ns']},"
            f"{bench['iterations']}"
        )


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <llvm-uplc-raw.json>", file=sys.stderr)
        sys.exit(1)
    parse(sys.argv[1])
