# Configs under Nix and Home Manager

An attempt at a unified and cross-platform environment.

Credit to:
 - [Emilia](https://dev.to/synecdokey) and [this article](https://dev.to/synecdokey/nix-on-macos-2oj3) for the inspiration to use Nix and Home Manager
 - [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and [this video](https://www.youtube.com/watch?v=m8C0Cq9Uv9o) for most of the Neovim configs

## Setup

### Setting up Nix

Under [NixOS](https://nixos.org/) ensure that you have `gcc` and `unzip` installed.

Under MacOS, install Nix:

```
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

This installs Nix using the [Determinate Systems](https://determinate.systems/posts/determinate-nix-installer/) installer.

### Setting up Home Manager with this config

 - Clone this repo. If you don't you have `git` installed you can use `nix` to run it once-off: `nix run nixpkgs#git -- clone https://github.com/allank/dotfiles`
 - Run `./mklocal.sh` - this should copy the base `flake.nix` and `home.nix` into the root directory of the repo and personalise for your current user and system.
 - In this repo run: `nix run github:nix-community/home-manager -- switch --flake .`

*Note:* Currently under `Darwin` the Home Manager install tries to compile `wezterm` and fails.  The `mklocal.sh` script currently comments out the `wezterm` package until I can add a more elegant workaround.

## Usage

### Using Nix and Home Manager

 - Rebuilding your environment: `home-manager -- switch --flake .`
 - Garbage collecting old configurations: `sudo nix-collect-garbage -d`
 - Running a new appliction without installing: `nix-shell -p neofetch`

### Important key bindings

#### tmux

- `<Leader>`: `<C-s>`
- New Window: `<C-s><c>`
- Toggle to last Window: `<C-s><l>`
- Next Window: `<C-s><n>`
- Previous Window: `<C-s><p>`
- Toggle Window Fullscreen: `<C-s><z>`

#### Neovim

- `<Leader>`: `<Space>`
- Search keymaps: `<Space><s><k>`
- Open file browser: `<Space><s><b>`
- Find file browser: `<Space><s><f>`
- Open buffers: `<Space><Space>`
- Neovim configs: `<Space><s><n>`
- Search current word: `<Space><s><w>`
- Find in current buffer: `<Space></>`
- Find in open buffers: `<Space><s></>`
- Find in all files: `<Space><s><g>`
- Search builtins: `<Space><s><s>`
- Search diagnostics: `<Space><s><d>`
- Next diagnostic: `<]><d>`
- Previous diagnostic: `<[><d>`
- Error messages: `<Space><e>`
- Quickfix list: `<Space><q>`
- Next buffer: `<Tab>`
- Previous buffer: `<S-Tab>`
- Close buffer: `<Space><b><d>`
- Goto definition: `<g><d>`
- Return to last position: `<C-t>`
- Find references: `<g><r>`
- Jump to implementation: `<g><I>`
- Jump to type definition: `<Space><D>`
- Find symbols: `<Space><d><s>`
- Find all symbols: `<Space><w><s>`
- Rename variable: `<Space><r><n>`
- Execute code action: `<Space><c><a>`
- Documentation popup: `<K>`
- Goto declaration: `<g><D>`

