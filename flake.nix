{
  description = "NixOs configuration flake";

  nixConfig = {
    extra-substituters = [
      "https://nixos-raspberrypi.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
    ];
  };

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
    nixos-raspberrypi = {
      url = "github:nvmd/nixos-raspberrypi/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, zen-browser, nixos-raspberrypi, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      nixosSystem = import ./lib/nixosConfig.nix;
      nixosPiSystem = import ./lib/nixosPiConfig.nix;
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
        nix-pi = nixosPiSystem "nix-pi" (inheritImportant { system = "aarch64-linux"; });
      };
      devShells.${system} = nixShells {
        pkgs = import nixpkgs-unstable { inherit system; };
      };
    };
}
