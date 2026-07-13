#!/bin/bash

# Check input
if [ $# -ne 1 ]; then
    echo "Usage: $0 <simulation_log_file>"
    exit 1
fi

LOGFILE="$1"

# Check file existence
if [ ! -f "$LOGFILE" ]; then
    echo "Error: Log file not found."
    exit 1
fi

# Count occurrences (case-sensitive as requested)
ERROR_COUNT=$(grep -c "ERROR" "$LOGFILE")
WARNING_COUNT=$(grep -c "WARNING" "$LOGFILE")
PASS_COUNT=$(grep -c "PASS" "$LOGFILE")

echo "===== Simulation Summary ====="
echo "Errors   : $ERROR_COUNT"
echo "Warnings : $WARNING_COUNT"
echo "Passed   : $PASS_COUNT"
echo "=============================="

# Exit condition
if [ "$ERROR_COUNT" -gt 0 ]; then
    echo "Simulation FAILED (errors found)"
    exit 1
else
    echo "Simulation OK (no errors)"
    exit 0
fi
