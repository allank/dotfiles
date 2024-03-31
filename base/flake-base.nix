{
  description = "allank dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {
    homeConfigurations = {
      "<USER>" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.<SYSTEM>;
        modules = [ ./home.nix ];
      };
    };
  };
}
