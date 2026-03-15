#!/bin/bash
set -euo pipefail

RUN_DIR="$1"
DATA_DIR="/bench/data/plutus_use_cases"
BENCH_DIR="/bench/opshin"

echo "opshin-uplc (Python)"

cd "$BENCH_DIR"

# Patch the hardcoded multi-line BENCH_DIR assignment to use canonical data
python3 -c "
import re
with open('bench_plutus_use_cases.py') as f:
    code = f.read()
code = re.sub(
    r'BENCH_DIR\s*=\s*os\.path\.expanduser\([^)]+\)',
    'BENCH_DIR = \"${DATA_DIR}\"',
    code,
)
with open('bench_plutus_use_cases.py', 'w') as f:
    f.write(code)
"

# Run benchmark (use Python 3.14 from build stage, not Ubuntu's 3.12)
python3.14 bench_plutus_use_cases.py 2>&1 | tee "$RUN_DIR/opshin-raw.log"

# Parse into unified CSV
python3 /bench/parsers/parse_opshin.py "$RUN_DIR/opshin-raw.log" > "$RUN_DIR/opshin.csv"

# Append failures from log as -1 entries
{ grep "SKIP (eval error)" "$RUN_DIR/opshin-raw.log" || true; } | while read -r line; do
    script=$(echo "$line" | awk '{print $1}')
    echo "opshin,$script,-1,-1,-1,-1,-1,0" >> "$RUN_DIR/opshin.csv"
done

# Fill in -1 for any scripts that were given but produced no result
python3 /bench/parsers/fill_failures.py "$RUN_DIR/opshin.csv" "$DATA_DIR" opshin "$RUN_DIR/opshin-raw.log"
