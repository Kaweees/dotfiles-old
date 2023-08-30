LN := ln -svf
MKDIR := mkdir -p
OS := $(shell uname)
USERNAME := $(shell whoami)
XDG_CONFIG := $(HOME)/.config
XDG_LOCAL := $(HOME)/.local

# Define the stow command and the target directory
STOW := stow
STOW_DIR := ~/dotfiles

# List of packages (subdirectories in your dotfiles directory)
PACKAGES := package1 package2 package3

# Additional directories
CONFIG := $(PWD)/.config
LOCAL := $(PWD)/.local

# Default target: stow all packages, .config, and .local
all: $(PACKAGES) $(CONFIG) $(LOCAL)

# Target to stow a specific package
$(PACKAGES):
	$(STOW) -R $@

# Target to unstow a specific package
uninstall-%:
	$(STOW) -D $*

# Target to stow .config
$(CONFIG): dwm git neovim zsh

dwm:
	$(STOW) --restow --dir $(CONFIG)/dwm --target $(HOME)/dwm

git:
	$(STOW) --restow --dir $(CONFIG)/git --target $(HOME)

neovim:
	$(STOW) --restow --dir $(CONFIG)/nvim --target $(XDG_CONFIG)

zsh:
	$(STOW) --restow --dir $(CONFIG)/zsh --target $(HOME)

# Target to stow .local
$(LOCAL):
	$(STOW) --restow --dir $(LOCAL) --target $(XDG_LOCAL)

# Target to clean up (unstow) all packages, .config, and LOCAL
clean:
	@for pkg in $(PACKAGES) $(CONFIG) $(LOCAL); do \
		$(STOW) -D $$pkg; \
	done

# Help target to display usage information
help:
	@echo "Usage: make <target>"
	@echo ""
	@echo "Targets:"
	@echo "  all              Stow all packages, .config, and .local"
	@echo "  clean            Unstow all packages, .config, and .local"
	@echo "  <package>        Stow a specific package (e.g., package1)"
	@echo "  uninstall-<package> Unstow a specific package (e.g., uninstall-package1)"
	@echo "  .config          Stow the .config directory"
	@echo "  .local           Stow the .local directory"
	@echo "  uninstall-.config Unstow the .config directory"
	@echo "  uninstall-.local Unstow the .local directory"

.PHONY: all clean $(PACKAGES) $(CONFIG) $(LOCAL) help dwm git neovim zsh
