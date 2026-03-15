#!/bin/bash
set -euo pipefail

RUN_DIR="$1"
DATA_DIR="/bench/data/plutus_use_cases"
BENCH_DIR="/bench/uplc-turbo"

echo "uplc-turbo AST (Rust / Criterion)"

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

# Clear previous criterion output to avoid stale results
rm -rf target/criterion

UPLC_BENCH_MODE=ast "$BENCH_BIN" --bench 2>&1 | tee "$RUN_DIR/uplc-turbo-raw.log" || true

# Collect failed scripts
FAILED_SCRIPTS=$(grep "^EVAL_FAIL:" "$RUN_DIR/uplc-turbo-raw.log" | sed 's/EVAL_FAIL: //' | sort -u || true)

# Copy Criterion JSON output (remove old copy first to avoid cp -r nesting)
rm -rf "$RUN_DIR/criterion-output-ast"
cp -r target/criterion "$RUN_DIR/criterion-output-ast" 2>/dev/null || true

# Parse criterion output, filtering out scripts that failed evaluation
python3 /bench/parsers/parse_criterion.py "$RUN_DIR/criterion-output-ast" > "$RUN_DIR/uplc-turbo-raw.csv"

# Filter: remove bogus timings for failed scripts, then add -1 entries
python3 -c "
import sys
failed = set('''$FAILED_SCRIPTS'''.split())
with open('$RUN_DIR/uplc-turbo-raw.csv') as f:
    lines = f.readlines()
with open('$RUN_DIR/uplc-turbo.csv', 'w') as out:
    out.write(lines[0])  # header
    for line in lines[1:]:
        script = line.split(',')[1] if ',' in line else ''
        if script not in failed:
            out.write(line)
    for script in sorted(failed):
        if script:
            out.write(f'uplc-turbo,{script},-1,-1,-1,-1,-1,0\n')
"

rm -f "$RUN_DIR/uplc-turbo-raw.csv"

# Fill in -1 for any scripts that were given but produced no result
python3 /bench/parsers/fill_failures.py "$RUN_DIR/uplc-turbo.csv" "$DATA_DIR" uplc-turbo "$RUN_DIR/uplc-turbo-raw.log"
