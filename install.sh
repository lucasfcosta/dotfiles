#!/usr/bin/env bash

# This has been shamelessly copied from mathiasbynens/dotfiles
# https://github.com/mathiasbynens/dotfiles/blob/b22c32290e1518c0f228afba254ee6a3f6ab6d7a/bootstrap.sh

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude "install.sh" \
		--exclude "README.md" \
		--exclude "LICENSE" \
		--exclude "terminal-demo.png" \
		-avh --no-perms . ~;

	if test -f "~/.bash_profile"; then
		source ~/.bash_profile;
	fi

	if test -f "~/.zsh_profile"; then
		source ~/.zsh_profile;
	fi
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
