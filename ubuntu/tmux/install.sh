#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

# install tmux
sudo apt-get install -y tmux > /dev/null

# config tmux
cp $DIR/.* ~/

