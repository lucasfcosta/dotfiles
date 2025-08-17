# ===============================
# History configuration
# ===============================
# Increase the default in-memory history size (zsh defaults to ~30 commands)
# and set the same number for the saved history so it persists between sessions.
# Store history in ~/.zsh_history for consistency.
# Ignore consecutive duplicate commands to reduce clutter.
# Share history in real-time across all running zsh sessions.
# Tip: Raise HISTSIZE/SAVEHIST for larger history (e.g., 50000+).
# Remove SHARE_HISTORY if you prefer separate history per terminal.
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY


# ===============================
# Completion system initialization
# ===============================
# Enable zsh's modern (compinit) completion system:
# - autoload -Uz compinit: makes the compinit function available
# - compinit: scans $fpath for completion scripts (e.g., _git, _kubectl)
#   and initializes programmable, context-aware completions.
# Without this, zsh falls back to the old, limited compctl system.
autoload -Uz compinit
compinit


# ===============================
# Shell environment configuration
# ===============================
# Load shell environment settings (nvm, paths, etc.)
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/shell-config.zsh" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/shell-config.zsh"


# ===============================
# Aliases
# ===============================
# Load personal aliases from external file
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliases.zsh" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliases.zsh"


# ===============================
# Key bindings
# ===============================
# Enable Vi-style keybindings in Zsh:
# - Normal mode (ESC) and Insert mode like in Vim.
bindkey -v

# Map Ctrl+R to an incremental reverse search through history
# (search results appear as you type, updating in real time).
bindkey '^R' history-incremental-search-backward

# ===============================
# Theme / Prompt configuration
# ===============================
# Load the main Zsh theme configuration from an external file.
# Uses XDG_CONFIG_HOME if set, otherwise defaults to ~/.config/zsh/main.zsh-theme.
# This keeps theme settings separate from .zshrc for cleaner organization,
# making it easier to update or swap themes without editing core shell config.
theme_file="${XDG_CONFIG_HOME:-$HOME/.config}/zsh/main.zsh-theme"
[ -f "$theme_file" ] && source "$theme_file"
