#!/usr/bin/env bash
# tsesh — dispatch tmux session launches through the base script.
# Install: symlink onto PATH, e.g.
#
# Usage:
#   tsesh dotfiles
#   tsesh payjoin
#   tsesh xsuxpayjoin
#   tsesh su <repo>
#   tsesh new <session-name> <directory>

BASE="$HOME/.config/tmux/sessions/dev-session.sh"
SU="$HOME/repo/github/xstoicunicornx"

case "$1" in
  dotfiles)
    exec "$BASE" "dotfiles" "$HOME/.dotfiles"
    ;;
  payjoin)
    exec "$BASE" "payjoin" "$HOME/repo/github/payjoin/rust-payjoin"
    ;;
  xsuxpayjoin)
    exec "$BASE" "xsux-payjoin" "$HOME/repo/github/xstoicunicornx/rust-payjoin"
    ;;
  su)
    # xstoicunicornx: any session name + repo
    shift
    name="$1"
    repo="$2"
    if [ -z "$name" ] || [ -z "$repo" ]; then
      echo "Usage: tsesh su <session-name> <repo>" >&2
      exit 1
    fi
    exec "$BASE" "$name" "$SU/$repo"
    ;;
  new)
    # Generic: any session name + directory
    shift
    name="$1"
    dir="$2"
    if [ -z "$name" ] || [ -z "$dir" ]; then
      echo "Usage: tsesh new <session-name> <directory>" >&2
      exit 1
    fi
    exec "$BASE" "$name" "$dir"
    ;;
  ""|-h|--help)
    echo "Usage: tsesh {dotfiles | payjoin | new <session-name> <directory>}" >&2
    exit 1
    ;;
  *)
    echo "tsesh: unknown session '$1'" >&2
    echo "Usage: tsesh {dotfiles | payjoin | new <session-name> <directory>}" >&2
    exit 1
    ;;
esac
