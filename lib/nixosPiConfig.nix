name: { lib, pkgs, pkgs-unstable, inputs, system }:

let
  data = import ./data.nix {};
  hostname = name;
  user = {
    userName = data.userName;
    fullName = data.fullName;
    userEmail = data.userEmail;
  };
in
  inputs.nixos-raspberrypi.lib.nixosSystem {
    inherit pkgs lib;

    specialArgs = {
      inherit inputs pkgs-unstable;
      inherit system;
      inherit hostname user;
      nixos-raspberrypi = inputs.nixos-raspberrypi;
    };

    modules = [
      ../hosts/${name}
      ../modules
      ../homelab
    ];
  }
