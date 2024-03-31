{ pkgs, ... }: {
  home = {
    stateVersion = "23.11";
    username = "allank";
    homeDirectory = "/home/allank";
    packages = with pkgs; [ 
      bat
      cargo
      delta
      eza
      fd
      fira-code-nerdfont
      fzf
      jq
      neovim
      python3
      ripgrep
      rustc
      tmux
    ];

    file.".config" = {
      source = ./config;
      recursive = true;
    };
  };

  xdg.enable = true;
  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "eza --color=always --git";
      cat = "bat";
      less = "bat";
    };
    oh-my-zsh = {
      enable = true;
      theme = "af-magic";
      plugins = [
        "git"
        "tmux"
      ];
    };
  };
}

