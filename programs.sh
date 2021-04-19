#!/usr/bin/env bash

# Like the other install script, this is from Mathias Bynens with slight modifications by me
# https://github.com/mathiasbynens/dotfiles/blob/bb6c76e410bf7b1693edfe60239461fc9205ec02/brew.sh

# Installing oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Installing brew formulae..."

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install fortune and strfile for the chucknorris plugin
brew install fortune
brew install strfile

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils

# Install GNU `sed`
brew install gnu-sed

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

# Install `wget`
brew install wget

brew install curl

# Install more recent versions of some macOS tools.
brew install neovim
brew install grep
brew install openssh

# Install other useful binaries.
brew install git
brew install tmux
brew install alacritty

arch -arm64 brew install reattach-to-user-namespace

# Install nvm and Node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install node


# -------------------------------
# Casks
# -------------------------------

# Install all casks
brew bundle --file=Cask -v


# -------------------------------
# Text editing
# -------------------------------

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


# -------------------------------
# Programs not managed by brew
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

# Installing rustup (for managing Rust)
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env
