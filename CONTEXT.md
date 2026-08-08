# Dotfiles

Personal macOS environment configuration, managed with chezmoi and bootstrapped via `bootstrap.sh`/`Brewfile.tmpl`.

## Language

**lazy.nvim**:
The Neovim plugin manager (`folke/lazy.nvim`) — installs and loads plugins declared in `lua/plugins/*.lua`. Present regardless of which plugin set is loaded on top of it.
_Avoid_: LazyVim (a different thing — see below), "the plugin manager" (name it explicitly)

**LazyVim**:
An opinionated Neovim distro/plugin bundle (`LazyVim/LazyVim`) that runs on top of `lazy.nvim` and imports a large default plugin set (LSP, completion, terminal, which-key, flash, etc.) via `import = "lazyvim.plugins"`. Dropping LazyVim does not mean dropping `lazy.nvim`.
_Avoid_: lazy.nvim, "the plugin manager"
