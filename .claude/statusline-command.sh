#!/bin/bash
input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd')

DIM=$'\033[2m'
YELLOW=$'\033[33m'
RED=$'\033[31m'
RESET=$'\033[0m'
SEP="${DIM} · ${RESET}"

# Worktree name: segment after ".claude/worktrees/" if present, else "main"
worktree_name=$(echo "$cwd" | sed -n 's|.*/.claude/worktrees/\([^/]*\).*|\1|p')
if [ -z "$worktree_name" ]; then
  worktree_name="main"
fi

# Context window — color shifts as usage grows, stays dim when low
ctx=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -n "$ctx" ]; then
  if [ "$ctx" -ge 90 ]; then
    ctx_color="$RED"
  elif [ "$ctx" -ge 70 ]; then
    ctx_color="$YELLOW"
  else
    ctx_color="$DIM"
  fi
  ctx_str="${ctx_color}[${ctx}%]${RESET}"
else
  ctx_str="${DIM}[—%]${RESET}"
fi

# PR number for the current branch
pr=$(gh pr view --json number --jq '.number' 2>/dev/null)
if [ -n "$pr" ]; then
  pr_str="${DIM}#${pr}${RESET}"
else
  pr_str=""
fi

if [ -n "$pr_str" ]; then
  printf "%s" "${DIM}${worktree_name}${RESET}${SEP}${pr_str} ${ctx_str}"
else
  printf "%s" "${DIM}${worktree_name}${RESET} ${ctx_str}"
fi
