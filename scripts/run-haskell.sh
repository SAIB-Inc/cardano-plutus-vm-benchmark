#!/bin/bash
set -euo pipefail

RUN_DIR="$1"
BENCH_DIR="/bench/haskell"

echo "plutus-core (Haskell / GHC / Criterion)"

# Symlink canonical flat files into the expected data location
rm -rf "$BENCH_DIR/validation/data"
mkdir -p "$BENCH_DIR/validation"
ln -sf /bench/data/plutus_use_cases "$BENCH_DIR/validation/data"

# Set Cabal Paths module data dir override
export plutus_benchmark_datadir="$BENCH_DIR"

# Clean any leftover from aborted runs (Criterion appends, causing duplicate headers)
rm -f "$RUN_DIR/haskell-criterion.csv"

# Run Criterion benchmark binary directly with CSV output
# The binary may exit non-zero after writing CSV (template file not found), so ignore exit code
"$BENCH_DIR/bin/validation" --csv "$RUN_DIR/haskell-criterion.csv" \
    2>&1 | tee "$RUN_DIR/haskell-raw.log" || true

# Parse Criterion CSV into unified CSV format
python3 /bench/parsers/parse_criterion_hs.py "$RUN_DIR/haskell-criterion.csv" > "$RUN_DIR/haskell.csv"
