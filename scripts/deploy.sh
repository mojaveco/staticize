#!/bin/bash

# Ensure the public directory exists
if [ ! -d "public" ]; then
  echo "Public directory not found. Please ensure it exists before deploying."
  exit 1
fi

# Run any build commands if needed (for example, a script to prepare files)
echo "Preparing files for deployment..."

# Add any build steps here if necessary
# For example, you might minify files or prepare static assets

# Deploy to Surge
echo "Deploying to Surge..."
surge ./public staticize.co

# Notify on success
if [ $? -eq 0 ]; then
  echo "Deployment to Surge was successful! Site is live at https://staticize.co"
else
  echo "Deployment failed."
fi
