autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true

# One small hook: add '?' for untracked, or 'ok' if everything is clean
zstyle ':vcs_info:git*+set-message:*' hooks git-simple-status
+vi-git-simple-status() {
  local marks=""

  # Add untracked marker if needed
  if git status --porcelain 2>/dev/null | grep -q '^??'; then
    marks="?"
  fi

  # If nothing at all is staged/unstaged/untracked → show "ok"
  if [[ -z ${hook_com[staged]} && -z ${hook_com[unstaged]} && -z $marks ]]; then
    hook_com[misc]='clean'
  else
    hook_com[misc]="$marks"
  fi
}

function toon { echo -n "∂" }

function aws_prompt_info {
  local profile="${AWS_PROFILE:-${AWS_DEFAULT_PROFILE}}"
  if [[ -z "$profile" && -f "$HOME/.aws/config" ]]; then
    profile="default"
  fi
  [[ -n "$profile" ]] && echo " %F{208}aws:$profile%f"
}

theme_precmd() {
  # Reload theme colors dynamically from active theme file
  source ~/.config/zsh/theme-active.zsh

  # Update vcs_info styles with current colors (expand variables now)
  zstyle ':vcs_info:*' stagedstr   "%F{${ZSH_THEME_COLOR_CONTENT}}+%f"
  zstyle ':vcs_info:*' unstagedstr "%F{${ZSH_THEME_COLOR_CONTENT}}*%f"
  zstyle ':vcs_info:*' formats       "%F{${ZSH_THEME_COLOR_DECORATIVE}}<%F{${ZSH_THEME_COLOR_CONTENT}}%b%F{${ZSH_THEME_COLOR_DECORATIVE}}>%f %F{${ZSH_THEME_COLOR_DECORATIVE}}[%F{${ZSH_THEME_COLOR_CONTENT}}%c%u%m%F{${ZSH_THEME_COLOR_DECORATIVE}}]%f"
  zstyle ':vcs_info:*' actionformats "%F{${ZSH_THEME_COLOR_DECORATIVE}}(%F{${ZSH_THEME_COLOR_CONTENT}}%b%F{${ZSH_THEME_COLOR_DECORATIVE}}|%F{${ZSH_THEME_COLOR_CONTENT}}%a%F{${ZSH_THEME_COLOR_DECORATIVE}})%f %F{${ZSH_THEME_COLOR_DECORATIVE}}[%F{${ZSH_THEME_COLOR_CONTENT}}%c%u%m%F{${ZSH_THEME_COLOR_DECORATIVE}}]%f"

  vcs_info
}

setopt prompt_subst
PROMPT='%F{$ZSH_THEME_COLOR_DECORATIVE}$(toon)%f %F{$ZSH_THEME_COLOR_PATH}%~%f ${vcs_info_msg_0_}$(aws_prompt_info)
%F{$ZSH_THEME_COLOR_PROMPT}>%f '

autoload -U add-zsh-hook
add-zsh-hook precmd theme_precmd
