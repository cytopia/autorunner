ifneq (,)
.error This Makefile requires GNU Make.
endif

# -------------------------------------------------------------------------------------------------
# Default configuration
# -------------------------------------------------------------------------------------------------

.PHONY: help lint install uninstall

SHELL := /bin/bash
CURRENT_DIR = $(dir $(abspath $(lastword $(MAKEFILE_LIST))))


# --------------------------------------------------------------------------------------------------
# Default Target
# --------------------------------------------------------------------------------------------------
help:
	@echo
	@echo "# -------------------------------------------------------------------- #"
	@echo "# Linux autorunner Makefile                                            #"
	@echo "# -------------------------------------------------------------------- #"
	@echo
	@echo "install        Install autorunner into /usr/local/bin (requires root)"
	@echo "uninstall      Uninstall autorunner from /usr/local/bin (requires root)"
	@echo
	@echo "help           Show this help"
	@echo "lint           Locally lint project files and repository"
	@echo


# --------------------------------------------------------------------------------------------------
# Lint Targets
# --------------------------------------------------------------------------------------------------
lint:
	docker run --rm $$(tty -s && echo "-it" || echo) -v $(PWD):/mnt koalaman/shellcheck bin/autorunner

.PHONY: _lint-prepare
_lint-prepare:
	docker pull koalaman/shellcheck


# --------------------------------------------------------------------------------------------------
# Install/Uninstall Targets
# --------------------------------------------------------------------------------------------------
install:
	install -d /usr/local/bin
	install -m 755 bin/autorunner /usr/local/bin/autorunner

uninstall:
	rm /usr/local/bin/autorunner

