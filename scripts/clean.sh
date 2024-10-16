#!/bin/bash

# Define file patterns for temporary and log files
TEMP_FILES=("*.tmp" "*.log")

# Prompt user before deleting files
echo "This will clean up temporary and log files."

read -p "Are you sure you want to continue? (y/n): " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
  # Remove only temporary and log files, leaving the pages intact
  for pattern in "${TEMP_FILES[@]}"; do
    echo "Removing files matching: $pattern"
    find . -name "$pattern" -exec rm -f {} +
  done

  echo "Cleanup complete. Core files (pages, assets) were not affected."
else
  echo "Cleanup canceled."
fi
