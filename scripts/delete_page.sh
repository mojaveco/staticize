#!/bin/bash

# Check if a page name is provided
PAGE_NAME=$1

if [ -z "$PAGE_NAME" ]; then
  echo "Error: You must provide a page name to delete a page."
  exit 1
fi

# Define the website and public directory
WEBSITE_DIR="websites/Staticize"  # Adjust dynamically if needed
PUBLIC_DIR="$WEBSITE_DIR/public"
PAGES_DIR="$PUBLIC_DIR/pages"
NAV_FILE="$PUBLIC_DIR/layouts/nav.html"

# Check if the page exists
PAGE_FILE="$PAGES_DIR/$PAGE_NAME.html"
if [ ! -f "$PAGE_FILE" ]; then
  echo "Page '$PAGE_NAME.html' does not exist."
  exit 1
fi

# delete the page file
rm "$PAGE_FILE"
echo "Deleting page: $PAGE_FILE"

# Check if the page exists in the navigation and delete it
if grep -q "$PAGE_NAME" "$NAV_FILE"; then
  echo "Updating navigation to delete $PAGE_NAME..."
  sed -i '' "/$PAGE_NAME/d" "$NAV_FILE"
  echo "Page '$PAGE_NAME' successfully deleted from the navigation."
else
  echo "Page '$PAGE_NAME' was not in the navigation."
fi

echo "Page '$PAGE_NAME' successfully deleted."
