#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

sudo apt-get install -y vim > /dev/null

# setup vundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# copy vimrc
cp $DIR/.vimrc ~/.vimrc
