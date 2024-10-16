.PHONY: create destroy deploy clean help

# Default behavior if no target is provided
default: help

# Create Page
page:
	@bash scripts/generate_page.sh $(name) nav=$(nav)

# Deploy the site
deploy:
	@./scripts/deploy.sh

# Clean up the project
clean:
	@./scripts/clean.sh

# Make a new Website
website:
	@bash scripts/create_website.sh

# Catch-all target to prevent errors with additional arguments
%:
	@:

# Help target (shows usage instructions)
help:
	@echo "Usage:"
	@echo "  make create <page-name>                # Create a new page"
	@echo "  make destroy <page-name>               # Remove an existing page"
	@echo "  make deploy                            # Deploy the site to Surge"
	@echo "  make clean                             # Clean up generated files"
	@echo ""
	@echo "Examples:"
	@echo "  make create about"
	@echo "  make destroy about"
