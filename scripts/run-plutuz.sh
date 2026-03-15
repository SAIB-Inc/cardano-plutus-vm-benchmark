#!/bin/bash
set -euo pipefail

RUN_DIR="$1"
DATA_DIR="/bench/data/plutus_use_cases"
BENCH_DIR="/bench/plutuz"

echo "Plutuz (Zig)"

# Symlink canonical flat files into expected location
rm -rf "$BENCH_DIR/bench/plutus_use_cases"
ln -sf "$DATA_DIR" "$BENCH_DIR/bench/plutus_use_cases"

# Ensure results directory exists
mkdir -p "$BENCH_DIR/bench/results"

cd "$BENCH_DIR"

# Run pre-compiled bench binary
./zig-out/bin/bench 2>&1 | tee "$RUN_DIR/plutuz-raw.log"

# Copy JSON output
cp bench/results/plutus_use_cases.json "$RUN_DIR/plutuz-raw.json" 2>/dev/null || true

# Parse into unified CSV
python3 /bench/parsers/parse_plutuz_json.py "$RUN_DIR/plutuz-raw.json" > "$RUN_DIR/plutuz.csv"

# Fill in -1 for any scripts that were given but produced no result
python3 /bench/parsers/fill_failures.py "$RUN_DIR/plutuz.csv" "$DATA_DIR" plutuz "$RUN_DIR/plutuz-raw.log"
