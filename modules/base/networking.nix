{ config, lib, pkgs, hostname, ... }:

let
  cfg = config.modules.base.networkmanager;
in
{
  options.modules.base.networkmanager = {
    enable = lib.mkEnableOption "networkmanager";
  };

  config = lib.mkMerge [
    ({
      networking.hostName = hostname;
      networking.firewall = {
        enable = lib.mkDefault true;
        allowedTCPPorts = [ 8080 57621 ];
        allowedUDPPorts = [ 5353 ];
      };
    })
    (lib.mkIf cfg.enable {
      environment.systemPackages = [
        pkgs.networkmanagerapplet
      ];

      networking.networkmanager.enable = true;
    })
  ];
}
