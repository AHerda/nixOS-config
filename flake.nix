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

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let 
      version = "24.05";
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      nixosSystem = import ./lib/nixosConfig.nix;
      unfree = import ./lib/unfree.nix {};
      pkgs = import nixpkgs {
        inherit system;
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfreePredicate = pkg:
          builtins.elem (lib.getName pkg) unfree;
      };
      inheritImportant = {
          inherit lib pkgs pkgs-unstable;
          inherit inputs version;
      };
    in
    {
      nixosConfigurations = {
        nix-laptop = nixosSystem "nix-laptop" inheritImportant;
        normalIso = nixosSystem "normalIso" inheritImportant;
        serverIso = nixosSystem "serverIso" inheritImportant;
      };
    };
}
