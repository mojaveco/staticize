#!/bin/bash

# Function to copy core JS files
copy_core_js() {
  mkdir -p $WEBSITE_DIR/public/assets/js

  # Check if the core JS exists and print its path
  if [ -f "assets/js/app.js" ]; then
    cp assets/js/app.js $WEBSITE_DIR/public/assets/js/
    echo "Core JS (app.js) copied to $WEBSITE_DIR/public/assets/js/"
  else
    echo "Core JS (app.js) not found in $(pwd)/assets/js/"
  fi
}

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

# Function to copy theme assets dynamically (including all JS files)
copy_theme() {
  mkdir -p $WEBSITE_DIR/public/assets/css
  mkdir -p $WEBSITE_DIR/public/assets/js

  # Copy theme CSS
  if [ -f "themes/$THEME/css/theme.css" ]; then
    cp themes/$THEME/css/theme.css $WEBSITE_DIR/public/assets/css/
  fi

  # Copy all theme JS files if they exist
  if [ -d "themes/$THEME/js" ] && [ "$(ls -A themes/$THEME/js/*.js 2>/dev/null)" ]; then
    cp themes/$THEME/js/*.js $WEBSITE_DIR/public/assets/js/
    echo "All JS files from themes/$THEME/js copied to $WEBSITE_DIR/public/assets/js/"
  else
    echo "No theme-specific JS files found to copy."
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

  # Copy layouts (nav, footer)
  if [ -d "templates/$TEMPLATE/layouts" ]; then
    cp -r templates/$TEMPLATE/layouts $WEBSITE_DIR/public/
  fi
}

# Function to set up the domain and create the CNAME file
setup_domain() {
  read -p "Enter your custom domain (or leave blank for default Surge domain): " DOMAIN
  if [ -z "$DOMAIN" ]; then
    DOMAIN="${WEBSITE_NAME}.surge.sh"
  fi

  # Create or update the CNAME file
  echo "$DOMAIN" > $WEBSITE_DIR/public/CNAME
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
elif [[ $THEME_CHOICE =~ ^[0-9]+$ ]] && [ $THEME_CHOICE -ge 1 ] && [ $THEME_CHOICE -le ${#themes_array[@]} ]]; then
  THEME=${themes_array[$THEME_CHOICE]}
else
  echo "Invalid choice, using default theme 'mojave'."
  THEME="mojave"
fi

# Prompt for template, defaulting to 'default'
read -p "Template (leave blank for default 'default'): " TEMPLATE
TEMPLATE=${TEMPLATE:-"default"}

# Create the website directory
WEBSITE_DIR="websites/$WEBSITE_NAME"
mkdir -p $WEBSITE_DIR/public
mkdir -p $WEBSITE_DIR/public/assets
mkdir -p $WEBSITE_DIR/public/pages
mkdir -p $WEBSITE_DIR/public/layouts

# Copy core JS (app.js)
copy_core_js
# Create theme and template files
copy_theme
copy_template

# Set up domain and generate CNAME file
setup_domain

echo "Website '$WEBSITE_NAME' created with theme '$THEME', template '$TEMPLATE', and domain '$DOMAIN'!"
