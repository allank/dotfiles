#!/bin/sh
# Claude Code hook: set this tmux pane's @agent_status for tmux-bar.
# Usage: tmux-agent-state.sh working|blocked|done|unset
# No-op outside tmux. See docs/tmux-bar.md in the dotfiles repo.
cat >/dev/null 2>&1   # hook input on stdin is not needed
[ -n "${TMUX_PANE:-}" ] || exit 0
tmux=/opt/homebrew/bin/tmux

before=$("$tmux" show -pv -t "$TMUX_PANE" @agent_status 2>/dev/null) || before=
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

# One notification per change into blocked, skipped when a focused tmux client
# is already showing this pane (the person is looking at it).
[ "$1" = blocked ] && [ "$before" != blocked ] || exit 0
"$tmux" list-clients -F '#{client_flags} #{pane_id}' 2>/dev/null |
  grep -q "focused.* $TMUX_PANE\$" && exit 0
where=$("$tmux" display -p -t "$TMUX_PANE" '#{?@space_name,#{@space_name},#{session_name}} / #{window_index}' 2>/dev/null)
# terminal-notifier lets a click show the pane (tspace focus). Without it, an
# osascript notification still shows, but a click opens Script Editor.
PATH="$PATH:/opt/homebrew/bin"
if command -v terminal-notifier >/dev/null 2>&1; then
  terminal-notifier -title "$where" -message "Claude needs you" -sound Glass \
    -group "tmux-bar-$TMUX_PANE" -execute "$HOME/.local/bin/tspace focus $TMUX_PANE" >/dev/null 2>&1 &
  exit 0
fi
osascript - "$where" >/dev/null 2>&1 <<'EOF'
on run argv
	display notification "Claude needs you" with title (item 1 of argv) sound name "Glass"
end run
EOF
exit 0
