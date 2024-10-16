#!/bin/bash

# Function to display available themes
list_themes() {
  echo "Available themes:"
  local i=1
  for theme in $(ls themes); do
    echo "$i) $theme"
    themes_array[i]=$theme
    ((i++))
  done
}

# Function to copy theme assets
copy_theme() {
  mkdir -p $WEBSITE_DIR/public/assets/css
  mkdir -p $WEBSITE_DIR/public/assets/js
  
  # Copy theme CSS
  if [ -f "themes/$THEME/css/theme.css" ]; then
    cp themes/$THEME/css/theme.css $WEBSITE_DIR/public/assets/css/
  fi

  # Copy theme JS
  if [ -f "themes/$THEME/js/app.js" ]; then
    cp themes/$THEME/js/app.js $WEBSITE_DIR/public/assets/js/
  fi
}

# Function to copy template files
copy_template() {
  # Copy main template files
  if [ -f "templates/$TEMPLATE/index.html" ]; then
    cp templates/$TEMPLATE/index.html $WEBSITE_DIR/public/
  fi

  # Copy additional pages
  if [ -d "templates/$TEMPLATE/pages" ]; then
    cp -r templates/$TEMPLATE/pages $WEBSITE_DIR/public/
  fi

  # Copy layouts (if any)
  if [ -d "templates/$TEMPLATE/layouts" ]; then
    cp -r templates/$TEMPLATE/layouts $WEBSITE_DIR/public/
  fi
}

# Interactive prompt for website name
read -p "Enter a website name: " WEBSITE_NAME
if [ -z "$WEBSITE_NAME" ]; then
  echo "Error: Website name is required."
  exit 1
fi

# List available themes and let the user choose
list_themes
read -p "Choose a theme (enter the number or press Enter for default 'mojave'): " THEME_CHOICE

# Set theme based on user selection
if [ -z "$THEME_CHOICE" ]; then
  THEME="mojave"
elif [[ $THEME_CHOICE =~ ^[0-9]+$ ]] && [ $THEME_CHOICE -ge 1 ] && [ $THEME_CHOICE -le ${#themes_array[@]} ]; then
  THEME=${themes_array[$THEME_CHOICE]}
else
  echo "Invalid choice, using default theme 'mojave'."
  THEME="mojave"
fi

# Prompt for template, defaulting to 'default'
read -p "Template (leave blank for default 'default'): " TEMPLATE
TEMPLATE=${TEMPLATE:-"default"}

# Check if multi-site mode is triggered (check if other websites exist)
if [ ! -d "websites" ]; then
  mkdir -p websites
fi

# Create the website directory
WEBSITE_DIR="websites/$WEBSITE_NAME"
mkdir -p $WEBSITE_DIR/public
mkdir -p $WEBSITE_DIR/public/assets
mkdir -p $WEBSITE_DIR/public/pages
mkdir -p $WEBSITE_DIR/public/layouts

# Create an empty CNAME file
touch $WEBSITE_DIR/public/CNAME

# Copy theme assets
copy_theme

# Apply the chosen template
copy_template

echo "Website '$WEBSITE_NAME' created with theme '$THEME' and template '$TEMPLATE'!"
