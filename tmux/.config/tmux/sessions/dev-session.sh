#!/usr/bin/env bash
# Base tmux session launcher.
# Usage: tmux-session.sh <session-name> <directory>
#
# Creates a session with two windows (zsh + nvim) at the given directory,
# or attaches if the session already exists.

SESSION="$1"
DIR="$2"

# Validate arguments
if [ -z "$SESSION" ] || [ -z "$DIR" ]; then
  echo "Usage: $(basename "$0") <session-name> <directory>" >&2
  exit 1
fi

# If it already exists, just attach.
tmux has-session -t "$SESSION" 2>/dev/null && if [ -n "$TMUX" ]; then
  exec tmux switch-client -t "$SESSION"
else
  exec tmux attach -t "$SESSION"
fi

# Window 1: zsh
tmux new-session -d -s "$SESSION" -n zsh -c "$DIR"

# Window 2: nvim
tmux new-window -t "$SESSION" -n nvim -c "$DIR"
tmux send-keys -t "$SESSION:nvim" 'nvim' C-m

# Start on the first window and attach
tmux select-window -t "$SESSION:zsh"
# Attach if outside tmux, switch if already inside one
if [ -n "$TMUX" ]; then
  exec tmux switch-client -t "$SESSION"
else
  exec tmux attach -t "$SESSION"
fi
