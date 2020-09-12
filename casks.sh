#!/usr/bin/env bash

# This install GUI applications

echo "Installing applications through brew casks..."

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed casks
brew cask upgrade

# Time for some action
brew cask install slack
brew cask install firefox
brew cask install firefox-nightly
brew cask install google-chrome
brew cask install spotify
brew cask install flux
brew cask install docker
brew cask install dropbox
brew cask install skype
brew cask install tunnelblick
brew cask install virtualbox
brew cask install virtualbox-extension-pack
brew cask install vlc
brew cask install evernote
brew cask install rocket
brew cask install kitty
