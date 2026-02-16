#!/usr/bin/env bash

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for ARM Macs
    if [[ $(uname -m) == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
fi

# Update Homebrew
brew update

# Install applications
echo "Installing applications..."
brew install --cask google-chrome
brew install --cask docker
brew install --cask alacritty
brew install curl
brew install neovim
brew install tmux
brew install nvm
brew install ripgrep

# Install fonts
echo "Installing fonts..."
brew install --cask font-fira-code-nerd-font

# Remove quarantine from Alacritty
sudo xattr -d com.apple.quarantine /Applications/Alacritty.app 2>/dev/null || true

# Set up Node.js via nvm
echo "Installing Node.js..."
export NVM_DIR="$HOME/.nvm"
mkdir -p "$NVM_DIR"
[ -s "$(brew --prefix nvm)/nvm.sh" ] && . "$(brew --prefix nvm)/nvm.sh"
nvm install node

# Install Claude Code
echo "Installing Claude Code..."
npm install -g @anthropic-ai/claude-code

# Install Claude Code plugins
if command -v claude &> /dev/null; then
    echo "Installing Claude Code plugins..."
    claude plugin install Notion@claude-plugins-official
    claude plugin install linear@claude-plugins-official
    claude plugin install context7@claude-plugins-official
fi

echo "Installation complete!"
echo "Run './install.sh' to set up dotfiles, then restart your terminal."
