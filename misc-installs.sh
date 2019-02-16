# This script installs other programs that are not managed
# by brew or that didn't fit into any of the other scripts

# This installs the spaceship theme for zsh
# https://github.com/denysdovhan/spaceship-prompt
if [ -d "{$ZSH_CUSTOM}/themes/spaceship-prompt"]
then
    echo "spaceship-prompt is already installed, skipping..."
else
    git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
fi

