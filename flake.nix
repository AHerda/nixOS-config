{
  description = "NixOs configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let 
      nixosSystem = import ./lib/nixosConfig.nix;
      version = "24.05";
    in
    {
      nixosConfigurations = {
        nix-laptop = nixosSystem "nix-laptop" {
          inherit inputs nixpkgs home-manager version;
          system = "x86_64-linux";
          # adtionalModules = [ nixos-hardware.nixosModules.microsoft-surface-pro-3 ];
        };
      };
    };
}
