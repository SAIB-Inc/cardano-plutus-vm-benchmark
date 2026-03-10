#!/bin/bash
set -euo pipefail

RUN_DIR="$1"
DATA_DIR="/bench/data/plutus_use_cases"
BENCH_DIR="/bench/uplc-turbo"

echo "uplc-turbo (Rust / Criterion)"

# Symlink canonical flat files into expected location
rm -rf "$BENCH_DIR/crates/uplc/benches/use_cases/plutus_use_cases"
ln -sf "$DATA_DIR" "$BENCH_DIR/crates/uplc/benches/use_cases/plutus_use_cases"

# Binary expects benches/use_cases/plutus_use_cases relative to cwd
cd "$BENCH_DIR/crates/uplc"

# Run Criterion benchmark (binary already compiled in build stage)
BENCH_BIN=$(find "$BENCH_DIR/target/release/deps" -name 'use_cases-*' -type f ! -name '*.d' | head -1)
if [[ -z "$BENCH_BIN" ]]; then
    echo "ERROR: could not find use_cases benchmark binary"
    exit 1
fi
chmod +x "$BENCH_BIN"
"$BENCH_BIN" --bench 2>&1 | tee "$RUN_DIR/uplc-turbo-raw.log"

# Copy Criterion JSON output (written relative to cwd, i.e. crates/uplc/)
cp -r target/criterion "$RUN_DIR/criterion-output" 2>/dev/null || true

# Parse into unified CSV
python3 /bench/parsers/parse_criterion.py "$RUN_DIR/criterion-output" > "$RUN_DIR/uplc-turbo.csv"
