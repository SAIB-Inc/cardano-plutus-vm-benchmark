#!/bin/bash
set -euo pipefail

RUN_DIR="$1"
DATA_DIR="/bench/data/plutus_use_cases"
BENCH_DIR="/bench/scalus"

echo "Scalus Hybrid JIT (Scala / JVM / JMH)"

cd "$BENCH_DIR"

# Copy canonical flat files into Scalus resource dir (may already exist from CEK run)
rm -rf bench/src/main/resources/data
mkdir -p bench/src/main/resources/data
cp "$DATA_DIR"/*.flat bench/src/main/resources/data/

# Build file list for JMH -p parameter
FILE_LIST=$(ls bench/src/main/resources/data/*.flat | xargs -I{} basename {} | paste -sd, -)

# Run JMH benchmark on the GraalVM 25 JDK (already in the runtime image at
# /opt/jdk-25 from build-julc). Same JVM + flag set as CEK. Graal optimizes
# the JIT-generated NativeStack bytecode much better than C2, rescuing the
# threshold regressions that depth=25000 (Dockerfile patch) would otherwise
# cause; net effect vs JDK 21 unpatched JIT is ~37% faster.
sbt "bench/Jmh/run -i 1 -wi 1 -w 5s -r 5s -f 1 -t 1 \
    -jvm /opt/jdk-25/bin/java \
    -jvmArgsAppend \"--enable-native-access=ALL-UNNAMED --sun-misc-unsafe-memory-access=allow -XX:+UseCompactObjectHeaders -XX:+UseG1GC -XX:+UseStringDeduplication -XX:MaxInlineLevel=15 -XX:MaxInlineSize=270 -XX:ReservedCodeCacheSize=512m -XX:InitialCodeCacheSize=64m -XX:+AlwaysPreTouch -Xms4g\" \
    -rff $RUN_DIR/scalus-jit-jmh.csv -p file=$FILE_LIST .*JITHybridBenchmark" \
    2>&1 | tee "$RUN_DIR/scalus-jit-raw.log"

# Parse JMH CSV into unified CSV
python3 /bench/parsers/parse_jmh.py "$RUN_DIR/scalus-jit-jmh.csv" scalus-jit > "$RUN_DIR/scalus-jit.csv"

# Fill in -1 for any scripts that were given but produced no result
python3 /bench/parsers/fill_failures.py "$RUN_DIR/scalus-jit.csv" "$DATA_DIR" scalus-jit "$RUN_DIR/scalus-jit-raw.log"
