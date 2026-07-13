#!/bin/bash

# Exit on error (-e), undefined variable (-u),
# and pipeline failure (-o pipefail)
set -euo pipefail

# ANSI Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# -----------------------------
# Function: Print usage
# -----------------------------
show_help() {
    echo "Usage: $0 [options] <log_file>"
    echo
    echo "Options:"
    echo "  -f <text|csv>    Output format"
    echo "  -o <file>        Save report to file"
    echo "  -c <file>        Compare against another log file"
    echo "  -v               Enable verbose mode"
    echo "  -h               Show help"
    echo
    echo "Examples:"
    echo "  $0 sample.log"
    echo "  $0 -f csv sample.log"
    echo "  $0 -o report.txt sample.log"
    echo "  $0 -v sample.log"
    echo "  $0 -c old.log new.log"
}

# -----------------------------
# Function: Validate log file
# -----------------------------
validate_file() {
    local file="$1"

    if [ ! -f "$file" ]; then
        echo "Error: File does not exist: $file"
        exit 1
    fi
}

# -----------------------------
# Default Values
# -----------------------------
FORMAT="text"
VERBOSE=false
OUTPUT_FILE=""
COMPARE=false
COMPARE_FILE=""
LOG_FILE=""

# -----------------------------
# Parse Arguments
# -----------------------------
while getopts ":f:o:c:vh" opt; do
    case ${opt} in
        f)
            FORMAT="$OPTARG"
            ;;
        o)
            OUTPUT_FILE="$OPTARG"
            ;;
        c)
            COMPARE=true
            COMPARE_FILE="$OPTARG"
            ;;
        v)
            VERBOSE=true
            ;;
        h)
            show_help
            exit 0
            ;;
        :)
            echo "Error: Option -$OPTARG requires an argument."
            exit 1
            ;;
        \?)
            echo "Error: Invalid option -$OPTARG"
            exit 1
            ;;
    esac
done

shift $((OPTIND - 1))

# Remaining argument is log file
LOG_FILE="${1:-}"

# -----------------------------
# Validate Input
# -----------------------------
if [ -z "$LOG_FILE" ]; then
    show_help
    exit 1
fi

validate_file "$LOG_FILE"

if [[ "$FORMAT" != "text" && "$FORMAT" != "csv" ]]; then
    echo "Error: Invalid format '$FORMAT'"
    exit 1
fi

# -----------------------------
# Compare Mode
# -----------------------------

if [ "$COMPARE" = true ]; then

    validate_file "$COMPARE_FILE"

    # Extract test names from PASS entries in old log
    OLD_PASS=$(grep "TEST PASS" "$COMPARE_FILE" | awk '{print $5}' | sort -u)

    # Extract test names from FAIL entries in new log
    NEW_FAIL=$(grep "TEST FAIL" "$LOG_FILE" | awk '{print $5}' | sort -u)

    echo "=== Regression Analysis ==="

    FOUND=false

    while read -r test; do
        [ -z "$test" ] && continue

        if echo "$NEW_FAIL" | grep -qx "$test"; then
            echo "REGRESSION: $test"
            FOUND=true
        fi
    done <<< "$OLD_PASS"

    if [ "$FOUND" = false ]; then
        echo "No regressions detected."
    fi

    exit 0
fi

# -----------------------------
# Verbose Logging
# -----------------------------
if [ "$VERBOSE" = true ]; then
    echo "[VERBOSE] Analyzing file: $LOG_FILE"
    echo "[VERBOSE] Output format: $FORMAT"
fi

# -----------------------------
# Analyze Log
# -----------------------------
PASS_COUNT=$(grep -c "TEST PASS" "$LOG_FILE" || true)
FAIL_COUNT=$(grep -c "TEST FAIL" "$LOG_FILE" || true)
SKIP_COUNT=$(grep -c "TEST SKIP" "$LOG_FILE" || true)

TOTAL=$((PASS_COUNT + FAIL_COUNT + SKIP_COUNT))

TIMES=$(grep -E "TEST PASS|TEST FAIL" "$LOG_FILE" \
    | grep -oE '[0-9]+\.[0-9]+s' \
    | tr -d 's')

AVG_TIME=$(echo "$TIMES" | awk '
{
    sum += $1
    count++
}
END {
    if (count > 0)
        printf "%.2f", sum/count
    else
        print "0.00"
}')

MIN_TIME=$(echo "$TIMES" | sort -n | head -1)
MAX_TIME=$(echo "$TIMES" | sort -n | tail -1)

MIN_TIME=${MIN_TIME:-0.00}
MAX_TIME=${MAX_TIME:-0.00}

if [ "$TOTAL" -gt 0 ]; then
    PASS_RATE=$(awk "BEGIN { printf \"%.2f\", ($PASS_COUNT/$TOTAL)*100 }")
else
    PASS_RATE="0.00"
fi

# -----------------------------
# Generate Output
# -----------------------------
REPORT=$(
if [ "$FORMAT" = "csv" ]; then

    echo "total,passed,failed,skipped,pass_rate"
    echo "$TOTAL,$PASS_COUNT,$FAIL_COUNT,$SKIP_COUNT,$PASS_RATE"

else

    echo "=== RISC-V Simulation Log Analysis ==="
    echo "Log file: $LOG_FILE"
    echo

    echo "--- Results Summary ---"
    echo "Total tests: $TOTAL"
    echo -e "Passed: $PASS_COUNT"
    echo -e "Failed: $FAIL_COUNT"
    echo -e "Skipped: $SKIP_COUNT"
    echo "Pass Rate: ${PASS_RATE}%"

    echo
    echo "--- Failed Tests ---"

    grep "TEST FAIL" "$LOG_FILE" | awk '{print $5}' || true

    echo
    echo "--- Timing Statistics ---"
    echo "Min time: ${MIN_TIME}s"
    echo "Max time: ${MAX_TIME}s"
    echo "Avg time: ${AVG_TIME}s"

fi
)

# -----------------------------
# Output Handling
# -----------------------------
if [ -n "$OUTPUT_FILE" ]; then

    echo "$REPORT" > "$OUTPUT_FILE"

    if [ "$VERBOSE" = true ]; then
        echo "[VERBOSE] Report written to $OUTPUT_FILE"
    fi

else

    echo "$REPORT"

fi

# -----------------------------
# Final Verdict
# -----------------------------
if [ "$FAIL_COUNT" -gt 0 ]; then
    echo -e "${RED}--- FINAL VERDICT: FAIL ---${NC}"
    exit 1
else
    echo -e "${GREEN}--- FINAL VERDICT: PASS ---${NC}"
    exit 0
fi
