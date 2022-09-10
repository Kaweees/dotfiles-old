#!/usr/bin/env bash

#################
# Let's install some dotfiles
# Are you ready?
################

git pull origin main;

function setupDotfiles() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "setup.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		-avh --no-perms . ~;
	source ~/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" -o "$1" == "-y" ]; then
	setupDotfiles;
else
  while true; do
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
    case $yn in
      [Yy]* )
        setupDotfiles;
      [Nn]* )
        break;
      * ) echo "Invalid input, please try again.";;
    esac
  done
unset setupDotfiles;
