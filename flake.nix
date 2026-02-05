{
  description = "My Professional NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nvf.url = "github:notashelf/nvf";
    niri.url = "github:YaLTeR/niri";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nvf, niri, home-manager, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; }; 
      modules = [
        ./configuration.nix
        nvf.nixosModules.default
        ./nvf-configuration.nix
        niri.nixosModules.niri
        home-manager.nixosModules.home-manager
      ];
    };
  };
}
