#!/bin/bash

# Ensure the public directory exists
if [ ! -d "public" ]; then
  echo "Public directory not found. Please ensure it exists before deploying."
  exit 1
fi

# Check if a CNAME file exists to get the domain
if [ -f "public/CNAME" ]; then
  DOMAIN=$(cat public/CNAME)
  echo "Deploying to domain: $DOMAIN"
else
  echo "Error: No CNAME file found. Please create a public/CNAME file with your custom domain."
  exit 1
fi

# Run any build commands if needed (for example, a script to prepare files)
echo "Preparing files for deployment..."

# Add any build steps here if necessary
# For example, you might minify files or prepare static assets

# Deploy to Surge using the domain from the CNAME file
echo "Deploying to Surge..."
surge ./public $DOMAIN

# Notify on success
if [ $? -eq 0 ]; then
  echo "Deployment to Surge was successful! Site is live at https://$DOMAIN"
else
  echo "Deployment failed."
fi
