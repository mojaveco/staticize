.PHONY: create destroy deploy clean help

# Default behavior if no target is provided
default: help

# Make Page
page:
	@if [ -z "$(name)" ]; then \
		echo "Error: You must provide a page name."; \
	else \
		bash scripts/generate_page.sh $(name) nav=$(nav); \
	fi

# Delete Page
delete:
	@if [ -z "$(name)" ]; then \
		echo "Error: You must provide a page name to delete."; \
	else \
		bash scripts/delete_page.sh $(name); \
	fi

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
	@echo "  make page name=<page-name> nav=<true|false>    # Create a new page"
	@echo "  make delete name=<page-name>                   # delete an existing page"
	@echo "  make deploy                                    # Deploy the site to Surge"
	@echo "  make clean                                     # Clean up generated files"
	@echo ""
	@echo "Examples:"
	@echo "  make page name=about nav=true"
	@echo "  make delete name=about"
