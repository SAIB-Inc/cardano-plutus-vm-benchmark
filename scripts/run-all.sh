#!/bin/bash
set -euo pipefail

RESULTS_DIR="${RESULTS_DIR:-/results}"
DATE=$(date +%Y-%m-%d)
RUN_DIR="${RESULTS_DIR}/${DATE}"
mkdir -p "$RUN_DIR"

echo "============================================="
echo " Cardano Plutus VM Benchmark Suite"
echo " $(date)"
echo "============================================="

# Record hardware fingerprint
{
    echo "date: $(date -Iseconds)"
    echo "kernel: $(uname -r)"
    echo "cpu: $(grep 'model name' /proc/cpuinfo | head -1 | cut -d: -f2 | xargs)"
    echo "cores: $(nproc)"
    echo "memory: $(free -h | awk '/Mem:/ {print $2}')"
} > "$RUN_DIR/environment.txt"

cat "$RUN_DIR/environment.txt"
echo ""

# Track which VMs to run (default: all)
VMS="${BENCH_VMS:-chrysalis,chrysalis-aot,uplc-turbo,plutigo,blaze-jsc,blaze-v8,plutuz,opshin}"

run_vm() {
    local vm_name="$1"
    local script="/bench/scripts/run-${vm_name}.sh"

    if [[ ! -f "$script" ]]; then
        echo "SKIP: no runner script for ${vm_name}"
        return 0
    fi

    echo ""
    echo "---------------------------------------------"
    echo " Running: ${vm_name}"
    echo "---------------------------------------------"

    if bash "$script" "$RUN_DIR"; then
        echo "OK: ${vm_name} completed"
    else
        echo "FAIL: ${vm_name} exited with code $?"
    fi
}

IFS=',' read -ra VM_LIST <<< "$VMS"
for vm in "${VM_LIST[@]}"; do
    vm=$(echo "$vm" | xargs)  # trim whitespace
    run_vm "$vm"
done

echo ""
echo "---------------------------------------------"
echo " Normalizing results"
echo "---------------------------------------------"

python3 /bench/parsers/normalize.py "$RUN_DIR"

echo ""
echo "---------------------------------------------"
echo " Generating report"
echo "---------------------------------------------"

python3 /bench/report/generate_report.py "$RUN_DIR"

echo ""
echo "============================================="
echo " Benchmark suite complete"
echo " Results: ${RUN_DIR}"
echo "============================================="
