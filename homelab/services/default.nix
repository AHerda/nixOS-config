{ pkgs, config, lib, ... }:

let
  cfg = config.homelab.services;
in {
  options.homelab.services = {
    enable = lib.mkEnableOption "Settings and services for the homelab";
  };

  imports = [
    ./audiobookshelf
    # ./collabora
    ./homepage
    ./immich
    ./memos
    ./nextcloud
    ./owncloud
    # ./onlyoffice
    ./vaultwarden
  ];

  config = lib.mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 80 443 ];
    services.caddy = {
      enable = true;
      package = pkgs.caddy.withPlugins {
        plugins = [ "github.com/caddy-dns/cloudflare@v0.2.4" ];
        hash = "sha256-7GoH8YLCoPmPExQxoga2FHB58zQDoZVf1BBwkVi0SsQ=";
      };
      environmentFile = "/etc/secrets/caddy.env";
    };
  };
}

