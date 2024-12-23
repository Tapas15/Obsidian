#!/bin/bash

# Automate Git Workflow with Change Detection

# Set variables
BRANCH="master" # Change this if your default branch is not 'main'

# Check for changes
if git diff-index --quiet HEAD --; then
    echo "No changes detected. Exiting."
    exit 0
else
    echo "Changes detected. Proceeding with commit and push."
fi

# Stage all changes (including deletions)
git add --all

# Commit changes with a timestamp
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
git commit -m "Auto-commit on $TIMESTAMP"

# Push changes to the remote repository
git push origin $BRANCH

echo "Changes tracked and pushed to remote repository on branch '$BRANCH' at $TIMESTAMP."
