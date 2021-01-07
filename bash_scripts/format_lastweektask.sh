#!/bin/bash

# Define the path to the file
file="/home/tigerit/TigerIT/projects/communicator-desktop-pwa/lastweektask.txt"

# Step 1: Remove first three characters from each line
awk '{print substr($0, 4)}' "$file" > tmp.txt && mv tmp.txt "$file"

# Step 2: Remove empty lines
grep -v '^[[:blank:]]*$' "$file" > "$file.tmp" && mv "$file.tmp" "$file"

# Step 3: Add line numbers to each non-empty line
awk '{printf("%d. %s\n", NR, $0)}' "$file" > tmp && mv tmp "$file"

echo "Processing completed successfully."
