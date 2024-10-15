#!/bin/bash

# Get the page name from the argument
PAGE_NAME=$1

# Capitalize the first letter of the page name manually
CAPITALIZED_PAGE_NAME="$(tr '[:lower:]' '[:upper:]' <<< ${PAGE_NAME:0:1})${PAGE_NAME:1}"

# Create the HTML file in the pages folder
cat <<EOT > public/pages/$PAGE_NAME.html
<h1>$CAPITALIZED_PAGE_NAME</h1>
<p>This is the $CAPITALIZED_PAGE_NAME page content.</p>
EOT

# Update the navigation to include the new page
# For macOS, use the -e flag with sed, and provide an empty backup suffix
sed -i '' "/<\/ul>/i\\
<li><a href=\"#\" data-page=\"$PAGE_NAME\">$CAPITALIZED_PAGE_NAME</a></li>" public/nav.html

echo "Page $PAGE_NAME.html created and added to the navigation!"

