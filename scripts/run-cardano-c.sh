#!/bin/bash
set -euo pipefail

RUN_DIR="$1"
DATA_DIR="/bench/data/plutus_use_cases"
BENCH_DIR="/bench/cardano-c"

echo "cardano-c CEK (C)"

cd "$BENCH_DIR"

# Run pre-compiled uplc-bench binary, emit JSON
./uplc-bench --quiet --format json -o "$RUN_DIR/cardano-c-raw.json" "$DATA_DIR" \
    2>&1 | tee "$RUN_DIR/cardano-c-raw.log"

# Parse into unified CSV
python3 /bench/parsers/parse_cardano_c_json.py "$RUN_DIR/cardano-c-raw.json" > "$RUN_DIR/cardano-c.csv"

# Fill in -1 for any scripts that were given but produced no result
python3 /bench/parsers/fill_failures.py "$RUN_DIR/cardano-c.csv" "$DATA_DIR" cardano-c "$RUN_DIR/cardano-c-raw.log"
