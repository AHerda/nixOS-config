{
  description = "NixOs configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # zen-browser.url = "github:MarceColl/zen-browser-flake";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
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
      inheritImportant = {additionalModules ? []}: {
        inherit inputs lib pkgs pkgs-unstable;
        inherit additionalModules;
      };
    in
    {
      nixosConfigurations = {
        nix-laptop = nixosSystem "nix-laptop" (inheritImportant {});
        work-laptop = nixosSystem "work-laptop" (inheritImportant
          { additionalModules = [ inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14 ]; });
        normalIso = nixosSystem "normalIso" (inheritImportant {});
        serverIso = nixosSystem "serverIso" (inheritImportant {});
      };
    };
}
