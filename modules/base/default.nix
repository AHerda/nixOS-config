{ lib, ... }:

{
  imports = [
    ./boot.nix
    ./locale.nix
    ./networking.nix
    ./nix.nix
    ./osSettings.nix
    ./packages.nix
    ./printing.nix
    ./proxy.nix
    ./security.nix
    ./ssh.nix
    ./users.nix
  ];
}
