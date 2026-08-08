# Drop the LazyVim distro in favor of hand-picked Neovim plugins

Neovim usage shifted from a coding-heavy workflow (needing LSP, AI assistance, an in-editor terminal) to light editing, mostly Markdown with occasional Python/Go. LazyVim's default plugin set (`import = "lazyvim.plugins"`) is built for the former and carries dozens of plugins regardless of which extras are enabled. We removed the LazyVim import entirely, kept `lazy.nvim` as the plugin manager, and hand-picked only what the new workflow needs: `snacks.nvim` (picker/explorer), `mini.nvim` (ai, surround, comment, pairs, statusline, icons), `gitsigns.nvim`, `catppuccin`, and `nvim-treesitter` for markdown/python/go/lua highlighting.

## Considered Options

Stripping LazyVim down module-by-module (keeping the distro import, disabling unwanted pieces via `opts`/`enabled = false`, as `disabled.lua` already did for telescope/bufferline) was rejected: it still carries LazyVim core's full plugin graph, and future LazyVim updates can silently re-enable things that were turned off.

## Consequences

- No LSP, no diagnostics, no in-editor terminal, no AI plugin, no `which-key`/`flash.nvim`.
- Formatting (`conform.nvim`) is kept but no longer installs its binaries via Mason — formatter binaries (`stylua`, `isort`, `goimports`) are installed via `Brewfile.tmpl` instead, consistent with how this repo already manages other dev tools.
- Solidity support (treesitter-only) was dropped; it wasn't part of the new workflow.
