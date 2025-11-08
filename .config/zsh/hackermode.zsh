# Toggle between light and dark themes
# Usage: hackermode on   (dark theme)
#        hackermode off  (light theme)
hackermode() {
  local mode="$1"
  local theme_state_file="$HOME/.config/theme-mode"
  local config_dir="$HOME/.config"

  # Determine target theme
  if [[ "$mode" == "on" ]]; then
    local theme="dark"
  elif [[ "$mode" == "off" ]]; then
    local theme="light"
  else
    echo "Usage: hackermode [on|off]"
    echo "  on  = dark theme (hacker mode)"
    echo "  off = light theme"
    return 1
  fi

  echo "Switching to $theme theme..."

  # Update symlinks for all components
  ln -sf "$config_dir/alacritty/colors-$theme.toml" "$config_dir/alacritty/colors-active.toml"
  ln -sf "$config_dir/zsh/theme-$theme.zsh" "$config_dir/zsh/theme-active.zsh"
  ln -sf "$config_dir/tmux/theme-$theme.conf" "$config_dir/tmux/theme-active.conf"

  # Save state for persistence
  echo "$theme" > "$theme_state_file"

  # Trigger Alacritty reload by touching config
  touch "$config_dir/alacritty/alacritty.toml"

  # ZSH: Source the new theme and reload prompt
  source "$config_dir/zsh/theme-active.zsh"
  source "$config_dir/zsh/main.zsh-theme"

  # Tmux: Reload configuration if tmux is running
  if command -v tmux &> /dev/null && tmux info &> /dev/null 2>&1; then
    tmux source-file "$config_dir/tmux/tmux.conf"
  fi

  echo "Theme switched to $theme mode!"
}
