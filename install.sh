#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")"

git pull origin master

function installZshAliases() {
	if [ -z "$ZSH_CUSTOM" ]; then
		if [ -n "$ZSH" ]; then
			ZSH_CUSTOM="$ZSH/custom"
		else
			ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
		fi
	fi
	mkdir -p "$ZSH_CUSTOM"
	if [ -f "./aliases.zsh" ]; then
		rsync -avh --no-perms ./aliases.zsh "$ZSH_CUSTOM/aliases.zsh"
	fi
}

function copyFiles() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude "install.sh" \
		--exclude "programs.sh" \
		--exclude "README.md" \
		--exclude "LICENSE" \
		--exclude "terminal-demo.png" \
		-avh --no-perms . ~

	if test -f ~/.bash_profile; then
		source ~/.bash_profile
	fi

	if test -f ~/.zprofile; then
		source ~/.zprofile
	fi
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	copyFiles
	installZshCustom
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo ""
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		copyFiles
		installZshCustom
	fi
fi

unset copyFiles
unset installZshAliases
