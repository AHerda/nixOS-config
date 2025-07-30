{ config, lib, pkgs, hostname, ... }:

let
  cfg = config.modules.base.networkmanager;
in {
  options.modules.base.networkmanager = {
    enable = lib.mkEnableOption "networkmanager";
    gui.enable = lib.mkEnableOption "GUI for Network Manager";
  };

  config = lib.mkMerge [
    {
      networking.hostName = hostname;
      networking.firewall = {
        enable = lib.mkDefault true;
        allowedTCPPorts = [ 22 80 ];
        allowedUDPPorts = [ ];
      };
    }
    (lib.mkIf cfg.enable {
      networking.networkmanager.enable = true;
    })
    (lib.mkIf cfg.gui.enable {
      programs.nm-applet.enable = true;
    })
  ];
}
