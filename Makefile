.PHONY: generate-page

# Define a rule for generating a page
generate-page:
	@./generate_page.sh $(name)

# Usage instructions for when no target is provided
help:
	@echo "Usage:"
	@echo "  make generate-page name=<page-name>"
	@echo ""
	@echo "Example:"
	@echo "  make generate-page name=about"
