.PHONY: clean install help

help:
	@echo "Available targets:"
	@echo "  clean    - Remove generated delta files"
	@echo "  install  - Run the RPMify installation script (requires sudo)"
	@echo "  help     - Show this help message"

clean:
	rm -f passwd_delta shadow_delta group_delta gshadow_delta wheel_users

install:
	sudo ./debianify.sh
