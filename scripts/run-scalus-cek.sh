#!/bin/bash
set -euo pipefail

RUN_DIR="$1"
DATA_DIR="/bench/data/plutus_use_cases"
BENCH_DIR="/bench/scalus"

echo "Scalus CEK (Scala / JVM / JMH)"

cd "$BENCH_DIR"

# Copy canonical flat files into Scalus resource dir
rm -rf bench/src/main/resources/data
mkdir -p bench/src/main/resources/data
cp "$DATA_DIR"/*.flat bench/src/main/resources/data/

# Build file list for JMH -p parameter
FILE_LIST=$(ls bench/src/main/resources/data/*.flat | xargs -I{} basename {} | paste -sd, -)

# Run JMH benchmark with all files, CSV output
sbt "bench/Jmh/run -i 3 -wi 3 -f 1 -t 1 -rff $RUN_DIR/scalus-cek-jmh.csv -p file=$FILE_LIST .*CekJVMBenchmark" \
    2>&1 | tee "$RUN_DIR/scalus-cek-raw.log"

# Parse JMH CSV into unified CSV
python3 /bench/parsers/parse_jmh.py "$RUN_DIR/scalus-cek-jmh.csv" scalus-cek > "$RUN_DIR/scalus-cek.csv"
