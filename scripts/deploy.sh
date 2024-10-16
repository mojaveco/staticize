#!/bin/bash

# Check if there are any websites to deploy
if [ ! -d "websites" ]; then
  echo "No websites directory found. Please generate a website first."
  exit 1
fi

# List available websites with a custom prompt
echo "Available websites:"
PS3="Please select a website to deploy: "  # Custom prompt for the select menu
select WEBSITE in $(ls websites); do
  if [ -n "$WEBSITE" ]; then
    echo "Deploying website: $WEBSITE"
    break
  else
    echo "Invalid selection, please choose again."
  fi
done

# Ensure the public directory exists for the selected website
if [ ! -d "websites/$WEBSITE/public" ]; then
  echo "Public directory not found for $WEBSITE. Please ensure it exists before deploying."
  exit 1
fi

# Check if the CNAME file exists and read the domain
if [ ! -f "websites/$WEBSITE/public/CNAME" ]; then
  echo "CNAME file not found for $WEBSITE. Please configure a domain before deploying."
  exit 1
fi

DOMAIN=$(cat "websites/$WEBSITE/public/CNAME")

# Deploy to Surge using the domain in the CNAME file
echo "Deploying $WEBSITE to Surge using domain $DOMAIN..."
surge "websites/$WEBSITE/public" "$DOMAIN"

# Notify on success
if [ $? -eq 0 ]; then
  echo "Deployment to Surge was successful! Site is live at https://$DOMAIN"
else
  echo "Deployment failed."
fi
