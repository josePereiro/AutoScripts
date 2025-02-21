#!/bin/bash
set -e

# Check if we're in a Git repository
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Error: Not a Git repository"
    exit 1
fi

# Add all changes
git add .

# Check if there are changes to commit
if git diff --cached --quiet; then
    echo "Nothing to commit"
    exit 0
fi

# Create commit message with timestamp
COMMIT_DATE=$(date +"%Y-%m-%d %H:%M:%S")
COMMIT_MSG="UP {$COMMIT_DATE}"

# Perform commit
git commit -m "$COMMIT_MSG"
echo "Committed changes with message: $COMMIT_MSG"