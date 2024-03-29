#!/usr/bin/env bash

# Like the other install script, this is from Mathias Bynens with slight modifications by me
# https://github.com/mathiasbynens/dotfiles/blob/bb6c76e410bf7b1693edfe60239461fc9205ec02/brew.sh

# Installing oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Use arch -arm64 if using an arm64 chip
INSTALL_CHIP_PREFIX="arch -arm64"
[[ $(uname -m) != "arm64" ]] && INSTALL_CHIP_PREFIX=""

# -------------------------------
# Essential programs
# -------------------------------

# Utils
$(INSTALL_CHIP_PREFIX) brew install wget
$(INSTALL_CHIP_PREFIX) brew install curl

# Alacritty
$(INSTALL_CHIP_PREFIX) brew install alacritty

# Git
$(INSTALL_CHIP_PREFIX) brew install git
$(INSTALL_CHIP_PREFIX) brew install git-lfs

$(INSTALL_CHIP_PREFIX) brew install docker
$(INSTALL_CHIP_PREFIX) brew install docker-compose
$(INSTALL_CHIP_PREFIX) brew install docker-machine

# Install more recent versions of some macOS tools.
$(INSTALL_CHIP_PREFIX) brew install grep
$(INSTALL_CHIP_PREFIX) brew install openssh
$(INSTALL_CHIP_PREFIX) brew install ssh-copy-id
$(INSTALL_CHIP_PREFIX) brew install gnu-sed

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
$(INSTALL_CHIP_PREFIX) brew install findutils

# Install GnuPG to enable PGP-signing commits.
$(INSTALL_CHIP_PREFIX) brew install gnupg

# This is needed for Telescope to be able to do live greps
# It is also a good CLI tool (faster than ag in many cases)
$(INSTALL_CHIP_PREFIX) brew install ripgrep

# Remove outdated versions from the cellar.
brew cleanup

# -------------------------------
# Text editing
# -------------------------------

# Change the user's life forever
# God bless the best text editor on earth
$(INSTALL_CHIP_PREFIX) brew install neovim

# Install vim-plug before installing plugins themselves
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install nvim plugins
nvim +PlugClean! +qall
nvim +GoInstallBinaries
nvim +silent +PlugInstall +qall

# vim's best friend
$(INSTALL_CHIP_PREFIX) brew install tmux

# install what's necessary for tmux to use
$(INSTALL_CHIP_PREFIX) brew install reattach-to-user-namespace

# install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm




# -------------------------------
# JS-related
# -------------------------------

# Install nvm and Node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install node


# -------------------------------
# Rust-related
# -------------------------------

# Installing rustup (for managing Rust)
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env

# Add necessary extensions for CoC support
rustup component add rls rust-analysis rust-src


# -------------------------------
# ZSH-related
# -------------------------------

# This installs the spaceship theme for zsh
# https://github.com/denysdovhan/spaceship-prompt
if [ -d "$ZSH/custom/themes/spaceship-prompt" ]
then
    echo "spaceship-prompt is already installed, skipping..."
else
    git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH/custom/themes/spaceship-prompt"
    ln -s "$ZSH/custom/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH/custom/themes/spaceship.zsh-theme"
fi


# -------------------------------
# Casks
# -------------------------------

for i in $(cat ./Cask); do $(INSTALL_CHIP_PREFIX) brew install "$i"; done
