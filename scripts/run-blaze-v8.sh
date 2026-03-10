#!/bin/bash
set -euo pipefail

RUN_DIR="$1"
DATA_DIR="/bench/data/plutus_use_cases"
BENCH_DIR="/bench/blaze-plutus"

echo "blaze-v8 (TypeScript / Node.js / V8)"

# Symlink canonical flat files into expected location
rm -rf "$BENCH_DIR/packages/blaze-plutus/bench/plutus_use_cases"
ln -sf "$DATA_DIR" "$BENCH_DIR/packages/blaze-plutus/bench/plutus_use_cases"

cd "$BENCH_DIR/packages/blaze-plutus"

# Run vitest bench via Node.js (V8 engine)
npx vitest bench --run \
    2>&1 | tee "$RUN_DIR/blaze-v8-raw.log"

# Parse into unified CSV
python3 /bench/parsers/parse_vitest.py blaze-v8 "$RUN_DIR/blaze-v8-raw.log" > "$RUN_DIR/blaze-v8.csv"
