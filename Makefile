.PHONY: all info help check check-self install uninstall clean docs
.DEFAULT_GOAL := all

# Hack to get the directory this makefile is in:
MKFILE_PATH := $(lastword $(MAKEFILE_LIST))
MKFILE_DIR := $(notdir $(patsubst %/,%,$(dir $(MKFILE_PATH))))
MKFILE_ABSDIR := $(abspath $(MKFILE_DIR))

PREFIX          ?= /usr/local
prefix          ?= $(PREFIX)
exec_prefix     ?= $(prefix)
bindir          ?= $(exec_prefix)/bin
CC              ?= cc
SHELL           ?= /bin/sh
SRCDIR          =  $(MKFILE_DIR)/src
VPATH           =  $(SRCDIR)
INSTALL         ?= install
INSTALL_PROGRAM ?= $(INSTALL)
DESTDIR         ?= $(bindir)

# Misc target info:
help_spacing  := 12

all: pomd4c ## Compile pomd4c

info: ## Print makefile settings, paths, etc
	@printf '%-16.16s = %s\n' "CC"               "$(CC)"
	@printf '%-16.16s = %s\n' "SHELL"            "$(SHELL)"
	@printf '%-16.16s = %s\n' "SRCDIR"           "$(SRCDIR)"
	@printf '%-16.16s = %s\n' "VPATH"            "$(VPATH)"
	@printf '%-16.16s = %s\n' "INSTALL"          "$(INSTALL)"
	@printf '%-16.16s = %s\n' "INSTALL_PROGRAM"  "$(INSTALL_PROGRAM)"
	@printf '%-16.16s = %s\n' "DESTDIR"          "$(DESTDIR)"
	@printf '%-16.16s = %s\n' "prefix"           "$(prefix)"
	@printf '%-16.16s = %s\n' "exec_prefix"      "$(exec_prefix)"
	@printf '%-16.16s = %s\n' "bindir"           "$(bindir)"


help: ## Print this makefile help menu
	@echo "TARGETS:"
	@grep '^[a-z_\-]\{1,\}:.*##' $(MAKEFILE_LIST) \
		| sed 's/^\([a-z_\-]\{1,\}\): *\(.*[^ ]\) *## *\(.*\)/\1:\t\3 (\2)/g' \
		| sed 's/^\([a-z_\-]\{1,\}\): *## *\(.*\)/\1:\t\2/g' \
		| awk '{$$1 = sprintf("%-$(help_spacing)s", $$1)} 1' \
		| sed 's/^/  /'
	@printf '\nNOTES:\n  The default installation prefix is "$(prefix)".\n'
	@printf  "  To install in a different location try:\n\n    %s" \
		'make prefix=/opt/my/other/path install'

pomd4c: pomd4c.c ## Build the pomd4c executable
	$(CC) $(CFLAGS) ./pomd4c.c -o ./pomd4c

check: pomd4c ## Run a quick check of the parser
	$(MKFILE_DIR)/pomd4c $(POMD4C_OPTS) \
		$(MKFILE_DIR)/examples/postproc/example.h

check-self: pomd4c # Run a quick check of the parser using the source
	$(MKFILE_DIR)/pomd4c $(POMD4C_OPTS) \
		$(SRCDIR)/*.h $(SRCDIR)/*.c

install: info pomd4c ## Install
	$(INSTALL_PROGRAM) -v -d $(DESTDIR)
	$(INSTALL_PROGRAM) -v pomd4c $(DESTDIR)

uninstall: info ## Remove install pomd4c
	rm -vf $(DESTDIR)$(bindir)/pomd4c

clean: ## Remove build artifacts
	rm -f ./pomd4c

docs: pomd4c ## Generate docs
	$(MKFILE_DIR)/pomd4c $(MKFILE_DIR)/pomd4c.c > ./API.md

