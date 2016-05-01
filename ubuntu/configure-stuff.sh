#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

# set zsh to the default shell
echo "Setting default shell for $(whoami) to zsh..."
chsh -s $(which zsh) $(whoami)

echo "Installing bullet-train theme..."
mkdir -p $ZSH_CUSTOM/themes/
wget --force-directories http://raw.github.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme -O $ZSH_CUSTOM/themes/bullet-train.zsh-theme

# install zshrc
echo "Copying .zshrc file to $(whoami)'s home folder..."
cp $DIR/zsh/.zshrc ~/.zshrc

# copy aliases to ~/.aliases
echo "Copying .aliases to $(whoami)'s home folder..."
cp $DIR/.aliases ~/.aliases

# copy terminator config to ~/.config/terminator
echo "Copying terminator config to $(whoami)'s home folder..."
mkdir -p $DIR/.config/terminator
cp $DIR/terminator/config .config/terminator/config

# source .zshrc
echo "Source .zshrc"
source ~/.zshrc

# change folder user zsh
sed -i s/"user-dir"/"$USER"/g ~/.zshrc

# installing vim plugins
echo "Installing vIM plugins..."
vim +PluginInstall +qall
