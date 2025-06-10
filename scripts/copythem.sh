#!/bin/bash

# Check for at least one argument
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 file1 [file2 ...]"
    exit 1
fi

# Temporary variable to store the combined output
output=""

# Iterate over all files
for file in "$@"; do
    if [ -f "$file" ]; then
        output+="========== $file ==========\n"
        output+="$(cat "$file")\n\n"
    else
        echo "Warning: '$file' is not a valid file, skipping."
    fi
done

# Copy to clipboard depending on the OS
if command -v xclip >/dev/null 2>&1; then
    echo -e "$output" | xclip -selection clipboard
    echo "Copied to clipboard using xclip."
elif command -v pbcopy >/dev/null 2>&1; then
    echo -e "$output" | pbcopy
    echo "Copied to clipboard using pbcopy."
else
    echo "No clipboard utility found (xclip or pbcopy required)."
    exit 2
fi
