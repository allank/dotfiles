# Fish configuration
# Converted from home-manager (modules/user.nix)

# PATH configuration
fish_add_path /opt/homebrew/bin
fish_add_path ~/.local/bin

# Aliases
alias ls="eza --color=always"
alias cat="bat"
alias less="bat"

# Key bindings for bash-style history expansion
function bind_bang
    switch (commandline -t)[-1]
        case "!"
            commandline -t -- $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function bind_dollar
    switch (commandline -t)[-1]
        case "!"
            commandline -f backward-delete-char history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

function fish_user_key_bindings
    bind ! bind_bang
    bind '$' bind_dollar
end

# Initialize starship prompt
if command -q starship
    starship init fish | source
end

# Initialize fzf key bindings
if command -q fzf
    fzf --fish | source
end

# Initialize grc (colorizer)
if command -q grc
    source /opt/homebrew/etc/grc.fish 2>/dev/null || true
end
