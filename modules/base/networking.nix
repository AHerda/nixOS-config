{ config, lib, pkgs-unstable, hostname, ... }:

let
  cfg = config.modules.base;
in {
  options.modules.base = {
    networkmanager = {
      enable = lib.mkEnableOption "networkmanager";
      gui.enable = lib.mkEnableOption "GUI for Network Manager";
    };
    avahi = {
      enable = lib.mkEnableOption "Weather to enable avahi service and publish hostaname to WLAN";
    };
    tailscale = {
      enable = lib.mkEnableOption "Weather to enable tailscale service";
    };
  };

  config = lib.mkMerge [
    {
      networking = {
        hostName = hostname;
        firewall = {
          enable = lib.mkDefault true;
          allowedTCPPorts = [ 22 ];
          allowedUDPPorts = [ ];
        };
      };
    }
    (lib.mkIf cfg.tailscale.enable {
      services.tailscale = {
        enable = true;
        package = pkgs-unstable.tailscale;
      };
    })
    (lib.mkIf cfg.networkmanager.enable {
      networking.networkmanager = {
        enable = true;
        wifi.backend = "iwd";
      };
    })
    (lib.mkIf cfg.networkmanager.gui.enable {
      programs.nm-applet.enable = true;
    })
    (lib.mkIf cfg.avahi.enable {
      services.avahi = {
        enable = true;
        nssmdns4 = true;
        nssmdns6 = true;
        publish = {
          enable = true;
          addresses = true;
          domain = true;
          userServices = true;
          workstation = true;
        };
      };
    })
  ];
}
