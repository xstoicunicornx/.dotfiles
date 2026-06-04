#!/usr/bin/env bash
# Print the parent directory for the git repository containing the given directory.
# Prints nothing if the directory isn't inside a git repo.
# Usage: tmux-repo-parent.sh <directory>

dir="${1:-$PWD}"

root=$(git -C "$dir" rev-parse --show-toplevel 2>/dev/null) || exit 0
[ -z "$root" ] && exit 0

printf '%s' "$(basename "$(dirname "$root")")"
