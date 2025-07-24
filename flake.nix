{
  description = "NixOs configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    raspberry-pi-nix = {
      url = "github:nix-community/raspberry-pi-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, zen-browser, raspberry-pi-nix, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      nixosSystem = import ./lib/nixosConfig.nix;
      nixShells = import ./shells/default.nix;
      unfree = import ./lib/unfree.nix {};
      inheritImportant = {system}: {
        inherit inputs lib;
        inherit system;
        pkgs = import nixpkgs {
          inherit system;
        };
        pkgs-unstable = import nixpkgs-unstable {
          inherit system;
          config = {
            allowUnfreePredicate = pkg:
              builtins.elem (lib.getName pkg) unfree;
            permittedInsecurePackages = [ "jujutsu-0.23.0" ];
          };
        };
      };
    in
    {
      nixosConfigurations = {
        nix-laptop = nixosSystem "nix-laptop" (inheritImportant { inherit system; });
        work-laptop = nixosSystem "work-laptop" (inheritImportant { inherit system; });
        normalIso = nixosSystem "normalIso" (inheritImportant { inherit system; });
        serverIso = nixosSystem "serverIso" (inheritImportant { inherit system; });
        nix-pi = nixosSystem "nix-pi" (inheritImportant { system = "aarch64-linux"; });
      };
      devShells.${system} = nixShells {
        pkgs = import nixpkgs-unstable { inherit system; };
      };
    };
}
