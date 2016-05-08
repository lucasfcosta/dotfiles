#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

# set zsh to the default shell
echo "Setting default shell for $(whoami) to zsh..."
echo "(You may need to reboot or relogin for this change to be applied)"
chsh -s $(which zsh) $(whoami)

echo "Installing bullet-train theme..."
wget --force-directories http://raw.github.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme -O $ZSH/custom/themes/bullet-train.zsh-theme > /dev/null

# install zshrc
echo "Copying .zshrc file to $(whoami)'s home folder..."
cp $DIR/../commons/zsh/.zshrc ~/.zshrc

# copy aliases to ~/.aliases
echo "Copying .aliases to $(whoami)'s home folder..."
cp $DIR/../commons/.aliases ~/.aliases

# source .zshrc
echo "Updating terminal configs..."
source ~/.zshrc

echo "Setting up Vundle..."
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim > /dev/null

# copy vimrc
echo "Copying .vimrc file to $(whoami)'s home folder..."
cp $DIR/../commons/vim/.vimrc ~/.vimrc

# installing vim plugins
echo "Installing vIM plugins..."
vim +PluginInstall +qall
