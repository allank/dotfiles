#!/bin/sh
# Claude Code hook: set this tmux pane's @agent_status for tmux-bar.
# Usage: tmux-agent-state.sh working|blocked|done|unset
# No-op outside tmux. See docs/tmux-bar.md in the dotfiles repo.
cat >/dev/null 2>&1   # hook input on stdin is not needed
[ -n "${TMUX_PANE:-}" ] || exit 0
tmux=/opt/homebrew/bin/tmux

if [ "$1" = unset ]; then
  "$tmux" set -p -u -t "$TMUX_PANE" @agent_status 2>/dev/null
  "$tmux" set -p -u -t "$TMUX_PANE" @agent 2>/dev/null
else
  "$tmux" set -p -t "$TMUX_PANE" @agent_status "$1" 2>/dev/null
  "$tmux" set -p -t "$TMUX_PANE" @agent claude-code 2>/dev/null
fi

# Push refresh so the menu bar changes at once, not on the next poll.
if [ -d /Applications/SwiftBar.app ]; then
  open -g "swiftbar://refreshplugin?name=tmux-bar" >/dev/null 2>&1
fi
exit 0
