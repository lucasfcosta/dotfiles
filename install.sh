#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude "install.sh" \
		--exclude "programs.sh" \
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
