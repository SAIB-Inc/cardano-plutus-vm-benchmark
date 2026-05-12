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

# Run JMH benchmark on the GraalVM 25 JDK (already in the runtime image at
# /opt/jdk-25 from build-julc). The -jvmArgsAppend flags target the forked
# benchmark JVM, not sbt itself (which stays on JDK 21). Compact object
# headers + Graal JIT + Scala-friendly inlining together give ~14% geo-mean
# speedup over the JDK 21 default.
sbt "bench/Jmh/run -i 1 -wi 1 -w 5s -r 5s -f 1 -t 1 \
    -jvm /opt/jdk-25/bin/java \
    -jvmArgsAppend \"--enable-native-access=ALL-UNNAMED --sun-misc-unsafe-memory-access=allow -XX:+UseCompactObjectHeaders -XX:+UseG1GC -XX:+UseStringDeduplication -XX:MaxInlineLevel=15 -XX:MaxInlineSize=270 -XX:ReservedCodeCacheSize=512m -XX:InitialCodeCacheSize=64m -XX:+AlwaysPreTouch -Xms4g\" \
    -rff $RUN_DIR/scalus-cek-jmh.csv -p file=$FILE_LIST .*CekJVMBenchmark" \
    2>&1 | tee "$RUN_DIR/scalus-cek-raw.log"

# Parse JMH CSV into unified CSV
python3 /bench/parsers/parse_jmh.py "$RUN_DIR/scalus-cek-jmh.csv" scalus-cek > "$RUN_DIR/scalus-cek.csv"

# Fill in -1 for any scripts that were given but produced no result
python3 /bench/parsers/fill_failures.py "$RUN_DIR/scalus-cek.csv" "$DATA_DIR" scalus-cek "$RUN_DIR/scalus-cek-raw.log"
