#!/bin/bash
# Switch tmux theme based on macOS appearance
# Called by dark-notify with "dark" or "light" as argument

DOTFILES="$HOME/cmd/src/dotfiles"
mode="${1:-dark}"

echo "$(date): switching to $mode" >> /tmp/dark-notify-tmux.log

if [ "$mode" = "light" ]; then
    conf="$DOTFILES/.tmux.light.conf"
else
    conf="$DOTFILES/.tmux.dark.conf"
fi

# Source theme in all running tmux servers
TMUX="/opt/homebrew/bin/tmux"
if [ -x "$TMUX" ] && [ -n "$(pgrep tmux)" ]; then
    "$TMUX" source-file "$conf"
fi
