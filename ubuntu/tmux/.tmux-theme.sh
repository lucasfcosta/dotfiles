# status bar
set -g status-interval 1
set -g status-justify centre
set -g status-bg colour234
set -g status-fg colour241

# user@hostname on left of status bar
set -g status-left-length 60
set -g status-left "#(id -un)@#h"

# clock on right of status bar
set -g status-right-length 60
set -g status-right "%d %b %Y - %H:%M:%S %p"

# default window title colors
set-window-option -g window-status-fg colour241
set-window-option -g window-status-bg default
set -g window-status-format "#I #W"

# active window title colors
set-window-option -g window-status-current-fg colour32
set-window-option -g window-status-current-bg default
set-window-option -g  window-status-current-format "#[bold]#I #W"
