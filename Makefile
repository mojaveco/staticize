.PHONY: default generate-page deploy clean help

# Default behavior if no target is provided
default: help

# Define a rule for generating a page
generate-page:
	@if [ -z "$(name)" ]; then \
		echo "Error: Please provide a page name. Example: make generate-page name=about"; \
		exit 1; \
	else \
		./scripts/generate_page.sh $(name); \
	fi

# Deploy the site
deploy:
	@./scripts/deploy.sh

# Clean up the project
clean:
	@./scripts/clean.sh

# Help target (shows usage instructions)
help:
	@echo "Usage:"
	@echo "  make generate-page name=<page-name>    # Generate a new page"
	@echo "  make deploy                            # Deploy the site to Surge"
	@echo "  make clean                             # Clean up generated files"
	@echo ""
	@echo "Example:"
	@echo "  make generate-page name=about"
