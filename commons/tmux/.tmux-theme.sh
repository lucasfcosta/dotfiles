# Start windows and panes at 1, not 0
set -g base-index 1
set -g pane-base-index 1

set-option -g repeat-time 0

# Removes ESC delay
set -sg escape-time 0

# List of plugins
set -g @tpm_plugins '                \
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

######################
### DESIGN CHANGES ###
######################

# panes
set -g pane-border-fg white
set -g pane-active-border-fg white

## Status bar design
# status line
set -g status-utf8 on
set -g status-justify left
set -g status-bg colour245
set -g status-fg white
set -g status-interval 2

# messaging
set -g message-fg black
set -g message-bg yellow
set -g message-command-fg blue
set -g message-command-bg black

#window mode
setw -g mode-bg colour6
setw -g mode-fg colour0

# window status
setw -g window-status-format " #F#I:#W#F "
setw -g window-status-current-format " #F#I:#W#F "
setw -g window-status-format "#[fg=black]#[bg=black] #I #[bg=black]#[fg=colour8] #W "
setw -g window-status-current-format "#[bg=black]#[fg=colour8] #I #[fg=colour8]#[bg=colour14] #W "
setw -g window-status-current-bg colour0
setw -g window-status-current-fg colour11
setw -g window-status-current-attr dim
setw -g window-status-bg green
setw -g window-status-fg black
setw -g window-status-attr reverse

# Info on left (I don't have a session display for now)
set -g status-left ''

# loud or quiet?
set-option -g visual-activity off
set-option -g visual-bell off
set-option -g visual-silence off
set-window-option -g monitor-activity off
set-option -g bell-action none

set -g default-terminal "screen-256color"

# The modes
setw -g clock-mode-colour colour135
setw -g mode-attr bold
setw -g mode-fg colour196
setw -g mode-bg colour238


# The panes
set -g pane-border-bg default
set -g pane-border-fg colour238
set -g pane-active-border-bg default
set -g pane-active-border-fg colour238


# The statusbar
set -g status-position bottom
set -g status-bg black
set -g status-fg colour137
set -g status-attr dim
set -g status-left '#[fg=white,bold] #S  ▶  '
set -g status-right '#[fg=white,bold,bg=black]   %d/%m/%y   %H:%M:%S   #{battery_icon} #{battery_percentage}'
set -g status-right-length 50
set -g status-left-length 20

# Battery icons
set -g @batt_charged_icon "♥"
set -g @batt_charging_icon "♥"
set -g @batt_discharging_icon "♥"
set -g @batt_attached_icon "♥"

setw -g window-status-current-fg red
setw -g window-status-current-bg black
setw -g window-status-current-attr bold
setw -g window-status-current-format '#[fg=red]#W'

setw -g window-status-fg white
setw -g window-status-bg black
setw -g window-status-attr none
setw -g window-status-format ' #[fg=white]#W#F '

setw -g window-status-bell-attr bold
setw -g window-status-bell-fg colour255
setw -g window-status-bell-bg colour1

# Pane resizing
bind H resize-pane -L 5
bind J resize-pane -D 5
bind K resize-pane -U 5
bind L resize-pane -R 5

# The messages
set -g message-attr bold
set -g message-fg black
set -g message-bg yellow


# Initialize TMUX plugin manager
run '~/.tmux/plugins/tpm/tpm'
