{ ... }:

{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    taps = [
      "nikitabobko/tap"
      "foundry-rs/foundry"
    ];
    brews = [
      "qemu"
      "colima"
      "gemini-cli"
      "foundry"
    ];
    casks = [ 
      "discord" 
      "spotify" 
      "whatsapp" 
      "bitwarden" 
      "obsidian" 
      "alfred" 
      "zotero" 
      "ghostty" 
      "firefox" 
      "transmission" 
      "hammerspoon"
      "karabiner-elements"
      "aerospace"
    ];
  };
}
