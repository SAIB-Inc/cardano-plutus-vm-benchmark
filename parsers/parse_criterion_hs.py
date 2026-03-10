#!/usr/bin/env python3
"""Parse Haskell Criterion CSV benchmark output into unified CSV.

Criterion's --csv flag produces:
  Name,Mean,MeanLB,MeanUB,Stddev,StddevLB,StddevUB
where Mean/Stddev are in seconds.
"""

import csv
import sys

VM_NAME = "haskell"
HEADER = "vm,script,mean_ns,median_ns,min_ns,max_ns,stddev_ns,iterations"


def parse(csv_path: str) -> None:
    print(HEADER)

    with open(csv_path) as f:
        reader = csv.DictReader(f)
        for row in reader:
            name = row["Name"]
            # Skip duplicate header rows
            if name == "Name":
                continue
            # Extract script name: "validation/script-name" → "script-name"
            # or "All/script-name" or just "script-name"
            script = name.split("/")[-1] if "/" in name else name

            mean_s = float(row["Mean"])
            stddev_s = float(row["Stddev"])
            mean_lb_s = float(row["MeanLB"])
            mean_ub_s = float(row["MeanUB"])

            mean_ns = int(mean_s * 1e9)
            stddev_ns = int(stddev_s * 1e9)
            # Use confidence interval bounds as min/max approximation
            min_ns = int(mean_lb_s * 1e9)
            max_ns = int(mean_ub_s * 1e9)
            # Criterion CSV doesn't include median or iteration count
            median_ns = mean_ns
            iterations = 0

            print(
                f"{VM_NAME},{script},"
                f"{mean_ns},{median_ns},{min_ns},{max_ns},"
                f"{stddev_ns},{iterations}"
            )


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <criterion-csv-file>", file=sys.stderr)
        sys.exit(1)
    parse(sys.argv[1])
