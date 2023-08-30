#!/usr/bin/env bash

#################
# Let's install some dotfiles
# Are you ready?
################

# Your existing code...

git pull origin main;

# Function to stow dotfiles using Makefile
function setupDotfiles() {
  # Assuming your Makefile is in the same directory as this script
  MAKEFILE_PATH="$(dirname "$0")/Makefile"

  # Check if the Makefile exists
  if [ -f "$MAKEFILE_PATH" ]; then
    # Run make with the "all" target
    make -f "$MAKEFILE_PATH"
  else
    echo "Makefile not found at $MAKEFILE_PATH"
    exit 1
  fi

  source ~/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" -o "$1" == "-y" ]; then
  setupDotfiles;
else
  while true; do
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " yn;
    case $yn in
      [Yy]* )
        setupDotfiles;
        ;;
      [Nn]* )
        break;
        ;;
      * ) echo "Invalid input, please try again.";;
    esac
  done
fi
unset setupDotfiles;
