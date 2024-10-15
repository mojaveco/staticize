#!/bin/bash

# Get the page name from the argument
PAGE_NAME=$1

# Create the HTML file in the pages folder
cat <<EOT > public/pages/$PAGE_NAME.html
<h1>${PAGE_NAME^}</h1>
<p>This is the $PAGE_NAME page content.</p>
EOT

# Update the navigation to include the new page
sed -i "/<\/ul>/i <li><a href=\"#\" data-page=\"$PAGE_NAME\">${PAGE_NAME^}</a></li>" public/nav.html

echo "Page $PAGE_NAME.html created and added to the navigation!"

