#!/bin/bash

# Create a temporary buffer file
BUFFER=$(mktemp)

# Add the tree structure
echo "===== PROJECT TREE =====" > "$BUFFER"
tree >> "$BUFFER"
echo -e "\n===== .go FILE CONTENTS =====" >> "$BUFFER"

# Find all .go files and append their content with headers
find . -type f -name "*.go" | while read -r file; do
    echo -e "\n======${file#./}=======" >> "$BUFFER"
    cat "$file" >> "$BUFFER"
done

# Copy to clipboard using xclip
xclip -selection clipboard < "$BUFFER"

# Optionally output a confirmation
echo "Copied project tree and .go files to clipboard."

# Clean up
rm "$BUFFER"
