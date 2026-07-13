#!/bin/bash

# Check input
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

DIR="$1"

# Check if directory exists
if [ ! -d "$DIR" ]; then
    echo "Error: Directory does not exist."
    exit 1
fi

echo "Analyzing: $DIR"
echo "--------------------------------"

# 1. Total number of files
file_count=$(find "$DIR" -type f | wc -l)

# 2. Total number of directories
dir_count=$(find "$DIR" -type d | wc -l)

echo "Total files: $file_count"
echo "Total directories: $dir_count"

echo "--------------------------------"

# 3. Largest file (name + size)
largest_file=$(find "$DIR" -type f -exec ls -lh {} + 2>/dev/null | sort -k5 -h | tail -n 1)

if [ -n "$largest_file" ]; then
    echo "Largest file:"
    echo "$largest_file"
else
    echo "No files found."
fi

echo "--------------------------------"

# 4. Most recently modified file
recent_file=$(find "$DIR" -type f -printf "%T@ %p\n" 2>/dev/null | sort -nr | head -n 1)

if [ -n "$recent_file" ]; then
    echo "Most recently modified file:"
    echo "$recent_file" | awk '{print $2}'
else
    echo "No files found."
fi
