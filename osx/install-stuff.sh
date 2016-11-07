#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

# Installing Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# create bin dir
mkdir -p $HOME/bin

# Install stuff
echo "Installing wget..."
brew install wget > /dev/null;

echo "Installing git..."
brew install git > /dev/null;

echo "Installing htop..."
brew install htop > /dev/null

echo "Installing curl..."
brew install curl > /dev/null

echo "Installing zsh..."
brew install zsh > /dev/null

echo "Installing vim..."
brew install vim > /dev/null

echo "Installing tmux..."
brew install tmux > /dev/null
brew install reattach-to-user-namespace

echo "Installing nvm..."
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash > /dev/null
source ~/.nvm/nvm.sh
nvm alias default stable

echo "Installing rvm..."
curl -sSL https://get.rvm.io | bash -s stable --ruby > /dev/null
rvm get head

echo "Installing oh-my-zsh..."
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash > /dev/null

echo "Installing powerline-fonts..."
git clone https://github.com/powerline/fonts | bash > /dev/null
bash fonts/install.sh > /dev/null
