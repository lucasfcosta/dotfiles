#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

echo Setting type speed configs for OSX...
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

echo Setting showAllFiles to true in order to show hidden files...
defaults write com.apple.finder AppleShowAllFiles YES
