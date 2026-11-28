-- Ghostty helpers for tspace (docs/tmux-bar.md in the dotfiles repo).
--   osascript ghostty.applescript ttys          -> one tty per line, e.g. /dev/ttys003
--   osascript ghostty.applescript focus <tty>   -> focuses that terminal; "ok" or "missing"
--   osascript ghostty.applescript new <command> -> opens a window running <command>
on run argv
	set action to item 1 of argv
	tell application "Ghostty"
		if action is "ttys" then
			set out to {}
			repeat with t in terminals
				set end of out to (tty of t)
			end repeat
			set AppleScript's text item delimiters to linefeed
			return out as text
		else if action is "focus" then
			set want to item 2 of argv
			repeat with t in terminals
				if (tty of t) is want then
					focus t
					activate
					return "ok"
				end if
			end repeat
			return "missing"
		else if action is "new" then
			set cfg to new surface configuration
			set command of cfg to (item 2 of argv)
			new window with configuration cfg
			activate
			return "ok"
		end if
	end tell
	error "unknown action: " & action
end run
