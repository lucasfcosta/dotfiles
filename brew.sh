#!/usr/bin/env bash

# Like the other install script, this is from Mathias Bynens with slight modifications by me
# https://github.com/mathiasbynens/dotfiles/blob/bb6c76e410bf7b1693edfe60239461fc9205ec02/brew.sh

echo "Installing brew formulae..."

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# This is needed for fzf to know how to ignore files listed in .gitignore
# and know how to show hidden files
# It is also a good CLI tool
brew install ag

# This is needed for python support on Neovim for YouCompleteMe
# Please see https://github.com/neovim/neovim/issues/1315
brew install python3
pip3 install --user --upgrade neovim

# Install `wget` with IRI support.
brew install wget --with-iri

brew install curl

# Install more recent versions of some macOS tools.
brew install neovim
brew install grep
brew install openssh

# Install other useful binaries.
brew install git
brew install yarn --without-node
brew install tmux
brew install alacritty



# -------------------------------
# Casks
# -------------------------------

brew install cask

# Dev utilities
brew cask install docker
brew cask install tunnelblick

# Browsers
brew cask install google-chrome
brew cask install firefox

# Communication
brew cask install rocket
brew cask install slack
brew cask install skype

# Change the user's life forever
# God bless the best text editor on earth
brew install vim
brew install neovim

# Install vim-plug before installing plugins themselves
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install nvim plugins
nvim +PlugClean! +qall
nvim +silent +PlugInstall +qall
python3 ~/.config/nvim/plugged/YouCompleteMe/install.py

# vim's best friend
brew install tmux

brew install git
brew install git-lfs
brew install ssh-copy-id

brew install docker
brew install docker-compose
brew install docker-machine

# Remove outdated versions from the cellar.
brew cleanup
