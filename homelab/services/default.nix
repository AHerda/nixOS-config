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
    ./readeck
    ./vaultwarden
  ];

  config = lib.mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 80 443 ];
    services.caddy = {
      enable = true;
      package = pkgs.caddy.withPlugins {
        plugins = [ "github.com/caddy-dns/cloudflare@v0.2.4" ];
        hash = "sha256-dQvk6ezY6TQ1J7PjhCXnThF/SqVgPwBO8/RXzHCY+js=";
      };
      environmentFile = "/etc/secrets/caddy.env";
    };
  };
}

