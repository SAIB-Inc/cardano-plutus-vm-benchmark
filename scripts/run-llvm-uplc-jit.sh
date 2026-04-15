#!/bin/bash
set -euo pipefail

RUN_DIR="$1"
DATA_DIR="/bench/data/plutus_use_cases"
BENCH_DIR="/bench/llvm-uplc"

echo "llvm-uplc JIT (C++ / LLVM LLJIT)"

cd "$BENCH_DIR"

# Run pre-compiled uplcbench binary in compiled (LLJIT) mode, emit JSON
./uplcbench --mode compiled --format json -o "$RUN_DIR/llvm-uplc-jit-raw.json" "$DATA_DIR" \
    2>&1 | tee "$RUN_DIR/llvm-uplc-jit-raw.log"

# Parse into unified CSV
python3 /bench/parsers/parse_llvm_uplc_json.py "$RUN_DIR/llvm-uplc-jit-raw.json" > "$RUN_DIR/llvm-uplc-jit.csv"

# Fill in -1 for any scripts that were given but produced no result
python3 /bench/parsers/fill_failures.py "$RUN_DIR/llvm-uplc-jit.csv" "$DATA_DIR" llvm-uplc-jit "$RUN_DIR/llvm-uplc-jit-raw.log"
