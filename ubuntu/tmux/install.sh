#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

# install tmux
sudo apt-get install -y tmux > /dev/null

# install TPM (TMUX Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm > dev/null

# config tmux
cp -R $DIR/.* ~/

