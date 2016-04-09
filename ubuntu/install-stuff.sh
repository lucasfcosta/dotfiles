#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

# enable adding ppas
sudo apt-get install software-properties-common -y

# add ppas
sudo add-apt-repository ppa:webupd8team/unstable
sudo add-apt-repository ppa:gnome-terminator

# create bub dir
mkdir -p $HOME/bin

# update packages
echo "Updating packages..."
sudo apt-get update > /dev/null

# Install stuff
echo "Installing git..."
sudo apt-get install -y git > /dev/null
echo "Installing guake..."
sudo apt-get install -y guake > /dev/null
echo "Installing htop..."
sudo apt-get install -y htop > /dev/null
echo "Installing curl..."
sudo apt-get install -y curl > /dev/null
echo "Installing zsh..."
sudo apt-get install -y zsh > /dev/null
echo "Installing vim..."
sh $DIR/vim/install.sh
echo "Installing tmux..."
sh $DIR/tmux/install.sh
echo "Installing nvm"
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash > /dev/null
echo "Installing rvm"
curl -sSL https://get.rvm.io | bash -s stable --ruby
echo "Installing oh-my-zsh"
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh > /dev/null
echo "Installing terminator"
sh $DIR/terminator/install.sh
echo "Installing powerline-fonts"
git clone https://github.com/powerline/fonts | sh > /dev/null
/bin/bash fonts/install.sh
