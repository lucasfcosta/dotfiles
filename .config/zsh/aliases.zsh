alias vim="nvim"
alias vimdiff="nvim -d"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Lock the screen (when going AFK)
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"

# Git log with file changes and line statistics
alias glg="git log --stat"

# Git worktrees
gwl() {
  local main_repo cwd
  main_repo=$(git worktree list --porcelain | awk '/^worktree/{print $2; exit}')
  [[ -z "$main_repo" ]] && { echo "Not in a git repo"; return 1; }
  cwd=$(git rev-parse --show-toplevel)
  git worktree list \
    | grep "^${main_repo}/" \
    | grep -v "^${cwd}[[:space:]]" \
    | sed "s|${main_repo}/||"
}

# gwc: checkout an existing branch in a new worktree
gwc() {
  local branch="${1:?Usage: gwc <existing-branch> [wt_path]}"
  local repo_root
  repo_root=$(git rev-parse --show-toplevel 2>/dev/null) || { echo "Not in a git repo"; return 1; }
  local wt_path="${2:-"${repo_root}/../$(basename "$repo_root")-${branch}"}"
  git worktree add "$wt_path" "$branch" && echo "Created worktree at: $wt_path"
}

# gwb: create a new branch (optionally from a source branch) in a new worktree
gwb() {
  local branch="${1:?Usage: gwb <new-branch> [from-branch] [wt_path]}"
  local from="${2:-HEAD}"
  local repo_root
  repo_root=$(git rev-parse --show-toplevel 2>/dev/null) || { echo "Not in a git repo"; return 1; }
  local wt_path="${3:-"${repo_root}/../$(basename "$repo_root")-${branch}"}"
  git worktree add -b "$branch" "$wt_path" "$from" && echo "Created worktree at: $wt_path"
}

gwcd() {
  local target="${1:?Usage: gwcd <branch-or-path>}"
  local wt_path
  wt_path=$(git worktree list --porcelain | awk -v t="$target" '
    /^worktree / { p = $2 }
    /^branch /   { if ($2 ~ t) print p }
  ' | head -1)
  [[ -z "$wt_path" ]] && wt_path=$(git worktree list --porcelain | awk '/^worktree / { print $2 }' | grep "$target" | head -1)
  [[ -z "$wt_path" ]] && { echo "No worktree matching: $target"; return 1; }
  cd "$wt_path"
}

gwclaude() {
  local branch="${1:?Usage: gwclaude <new-branch> [from-branch]}"
  gwb "$branch" "${2}" && gwcd "$branch" && claude
}

# Load hackermode theme switcher
source ~/.config/zsh/hackermode.zsh
