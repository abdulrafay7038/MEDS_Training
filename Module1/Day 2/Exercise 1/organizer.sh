#!/bin/bash

# Check if directory is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

DIR=$1

# Check if directory exists
if [ ! -d "$DIR" ]; then
    echo "Error: Directory does not exist"
    exit 1
fi

cd "$DIR" || exit

# Create target folders
mkdir -p verilog c_code docs others

# Loop through files
for file in *; do
    # Skip directories
    if [ -f "$file" ]; then

        # Extract extension
        ext="${file##*.}"

        case "$ext" in
            sv)
                mv "$file" verilog/
                ;;
            c)
                mv "$file" c_code/
                ;;
            txt)
                mv "$file" docs/
                ;;
            *)
                mv "$file" others/
                ;;
        esac
    fi
done

echo "Files organized successfully!"
