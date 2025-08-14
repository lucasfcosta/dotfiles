autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true

# Monochrome markers from vcs_info itself
zstyle ':vcs_info:*' stagedstr   '%F{245}+%f'
zstyle ':vcs_info:*' unstagedstr '%F{245}*%f'

# Branch box + status box
zstyle ':vcs_info:*' formats       '%F{240}<%F{245}%b%F{240}>%f %F{240}[%F{245}%c%u%m%F{240}]%f'
zstyle ':vcs_info:*' actionformats '%F{240}(%F{245}%b%F{240})%f %F{240}[%F{245}%c%u%m%F{240}]%f'

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
theme_precmd() { vcs_info }
setopt prompt_subst
PROMPT='%F{240}$(toon)%f %F{255}%~%f ${vcs_info_msg_0_}
%F{245}>%f '

autoload -U add-zsh-hook
add-zsh-hook precmd theme_precmd
