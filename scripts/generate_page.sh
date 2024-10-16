#!/bin/bash

# Check if a page name is provided
PAGE_NAME=$1
NAV_OPTION=$2

echo "Page name: $PAGE_NAME"
echo "Nav option: $NAV_OPTION"

if [ -z "$PAGE_NAME" ]; then
  echo "Error: You must provide a page name."
  exit 1
fi

# Capitalize the first letter of the page name using awk
CAPITALIZED_PAGE_NAME=$(echo "$PAGE_NAME" | awk '{ print toupper(substr($0,1,1)) tolower(substr($0,2)) }')

# Define the website and public directory
WEBSITE_DIR="websites/Staticize"  # Or dynamic if you'd like
PUBLIC_DIR="$WEBSITE_DIR/public"
PAGES_DIR="$PUBLIC_DIR/pages"
NAV_FILE="$PUBLIC_DIR/layouts/nav.html"

# Create the pages directory if it doesn't exist
mkdir -p $PAGES_DIR

# Create the new page file
PAGE_FILE="$PAGES_DIR/$PAGE_NAME.html"
if [ -f "$PAGE_FILE" ]; then
  echo "Page '$PAGE_NAME.html' already exists."
else
  echo "<h1>$CAPITALIZED_PAGE_NAME</h1>" > "$PAGE_FILE"
  echo "<p>This is the $PAGE_NAME page content.</p>" >> "$PAGE_FILE"
  echo "Page $PAGE_NAME.html created successfully."
fi

# If nav=true, update the navigation
if [ "$NAV_OPTION" == "nav=true" ]; then
  echo "Updating navigation..."
  if grep -q "$PAGE_NAME" "$NAV_FILE"; then
    echo "Navigation already contains a link to $PAGE_NAME."
  else
    # Add the new page to the navigation without href, using data-page
    sed -i '' "/<\/ul>/i\\
    <li><a href=\"#\" data-page=\"$PAGE_NAME\">$CAPITALIZED_PAGE_NAME</a></li>" $NAV_FILE
    echo "Page $PAGE_NAME added to the navigation."
  fi
else
  echo "Navigation update skipped."
fi
