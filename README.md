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

 - Clone this repo.
 - In this repo run: `nix run github:nix-community/home-manager -- switch --flake .`

## Usage

### Using Nix and Home Manager

 - Rebuilding your environment: `home-manager -- switch --flake .`
 - Garbage collecting old configurations: `sudo nix-collect-garbage -d`
 - Running a new appliction without installing: `nix-shell -p neofetch`

### Configured aliases


