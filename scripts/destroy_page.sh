#!/bin/bash

# Check if the page exists in the public/pages directory
PAGE_NAME=$1
PAGE_FILE="public/pages/$PAGE_NAME.html"

if [ -f "$PAGE_FILE" ]; then
  echo "Removing page: $PAGE_FILE"
  rm "$PAGE_FILE"

  # Safely remove the page from the navigation without affecting </ul>
  echo "Updating navigation to remove $PAGE_NAME..."
  sed -i '' "/<li><a href=\"#\" data-page=\"$PAGE_NAME\".*<\/li>/d" public/nav.html

  echo "Page '$PAGE_NAME' successfully removed."
else
  echo "Error: Page '$PAGE_NAME' does not exist."
fi
