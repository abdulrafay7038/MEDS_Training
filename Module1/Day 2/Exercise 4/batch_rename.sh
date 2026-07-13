#!/bin/bash

# Usage check
if [ $# -ne 3 ]; then
    echo "Usage: $0 <prefix> <suffix> <directory>"
    exit 1
fi

PREFIX="$1"
SUFFIX="$2"
DIR="$3"

# Directory validation
if [ ! -d "$DIR" ]; then
    echo "Error: Directory does not exist."
    exit 1
fi

# Track if any files were processed
found=0

# Loop through matching files
for file in "$DIR"/${PREFIX}_old_*.sv; do

    # Handle case where no match is found
    if [ ! -e "$file" ]; then
        continue
    fi

    found=1

    # Extract number N from filename
    base=$(basename "$file")
    num=$(echo "$base" | sed -n "s/${PREFIX}_old_\(.*\)\.sv/\1/p")

    # Build new filename
    newfile="$DIR/${SUFFIX}_new_${num}.sv"

    # Rename safely (avoid overwrite)
    if [ -e "$newfile" ]; then
        echo "Skipping (target exists): $newfile"
    else
        mv "$file" "$newfile"
        echo "Renamed: $base → $(basename "$newfile")"
    fi

done

# If no files matched
if [ "$found" -eq 0 ]; then
    echo "No matching files found in $DIR"
    exit 1
fi

exit 0
