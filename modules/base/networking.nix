{ lib, pkgs, hostname, ... }:

{
  environment.systemPackages = [
    pkgs.networkmanagerapplet
  ];

  networking.hostName = hostname;
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = lib.mkDefault true;
    allowedTCPPorts = [ 8080 57621 ];
    allowedUDPPorts = [ 5353 ];
  };
}
