{
  description = "NixOs configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager }@inputs:
    let 
      version = "24.05";
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        inherit system;
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      nixosSystem = import ./lib/nixosConfig.nix;
    in
    {
      nixosConfigurations = {
        nix-laptop = nixosSystem "nix-laptop" {
          inherit lib pkgs pkgs-unstable home-manager;
          inherit inputs version;
          # nixpkgs.config.allowUnfree = lib.mkForce true;
          # adtionalModules = [ nixos-hardware.nixosModules.microsoft-surface-pro-3 ];
        };
      };
    };
}
