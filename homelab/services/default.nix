{ config, lib, ... }:

let
  cfg = config.homelab.services;
in {
  options.homelab.services = {
    enable = lib.mkEnableOption "Settings and services for the homelab";
  };

  imports = [
    ./audiobookshelf
    ./homepage
    ./immich
  ];

  config = lib.mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 80 443 ];
    services.caddy = {
      enable = true;
      globalConfig = ''
        auto_https off
      '';
      # virtualHosts = {
      #   "http://${config.homelab.baseDomain}" = {
      #     extraConfig = ''
      #       redir http://{host}{uri}
      #     '';
      #   };
      #   "http://*.${config.homelab.baseDomain}" = {
      #     extraConfig = ''
      #       redir http://{host}{uri}
      #     '';
      #   };
      # };
    };
  };
}

