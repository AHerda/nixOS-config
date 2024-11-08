{ lib, ... }:

{
  imports = [
    ./boot.nix
    ./locale.nix
    ./networking.nix
    ./nix.nix
    ./osSettings.nix
    ./packages.nix
    ./services.nix
    ./ssh.nix
    ./users.nix
  ];
}
