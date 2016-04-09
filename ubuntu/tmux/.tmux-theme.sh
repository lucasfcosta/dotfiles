# Start windows and panes at 1, not 0
set -g base-index 1
set -g pane-base-index 1

set-option -g status-position top

set-option -g repeat-time 0

# Removes ESC delay
set -sg escape-time 0

# List of plugins
set -g @tpm_plugins '                \
    caiogondim/maglev                \
    tmux-plugins/tpm                 \
    tmux-plugins/tmux-sensible       \
    tmux-plugins/tmux-resurrect      \
    tmux-plugins/tmux-continuum      \
    tmux-plugins/tmux-yank           \
    tmux-plugins/tmux-pain-control   \
    tmux-plugins/tmux-copycat        \
    tmux-plugins/tmux-open           \
    tmux-plugins/tmux-battery        \
    tmux-plugins/tmux-cpu            \
'

# Initialize TMUX plugin manager
run '~/.tmux/plugins/tpm/tpm'
