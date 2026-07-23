{ config, lib, pkgs-unstable, ... }:

let
  cfg = config.homelab.services.immich;
  homelab = config.homelab;
  services = config.homelab.services;
in {
  options.homelab.services.immich = {
    enable = lib.mkEnableOption "Enable immich - self-hosted photo and video management solution";
    mediaDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/immich";
      description = "Directory in which the media will be stored";
    };
    port = lib.mkOption {
      type = lib.types.int;
      default = 2283;
      description = "Port to which immich will listen to";
    };
    host = lib.mkOption {
      default = "localhost";
      type = lib.types.str;
      description = "The host that immich will listen on";
    };
    url = lib.mkOption {
      type = lib.types.strMatching "[a-zA-Z0-9]+(\\.[a-zA-Z0-9]+)*";
      description = "Url to enter the Immich server";
      default = "photos.${homelab.baseDomain}";
    };
    homepage = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "Immich";
      };
      description = lib.mkOption {
        type = lib.types.str;
        default = "Self-hosted photo and video management tool";
      };
      icon = lib.mkOption {
        type = lib.types.str;
        default = "immich.svg";
      };
      category = lib.mkOption {
        type = lib.types.str;
        default = "Media";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.tmpfiles.rules = [ "d ${cfg.mediaDir} 0775 immich ${homelab.group} - -" ];
    services.immich = {
      enable = true;
      package = pkgs-unstable.immich;
      openFirewall = true;
      mediaLocation = "${cfg.mediaDir}";
      host = cfg.host;
      port = cfg.port;
    };
    users.users.immich.extraGroups = [
      "video"
      "render"
    ];
    services.caddy.virtualHosts."${cfg.url}".extraConfig = ''
      reverse_proxy http://${cfg.host}:${toString cfg.port}
      tls {
        dns cloudflare {env.CLOUDFLARE_API_TOKEN}
      }
    '';
  };
}
