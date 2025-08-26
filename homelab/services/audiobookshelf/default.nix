{ config, lib, ... }:

let
  cfg = config.homelab.services.audiobookshelf;
  homelab = config.homelab;
in {
  options.homelab.services.audiobookshelf = {
    enable = lib.mkEnableOption "Self hosted server for e-books, audiobooks and podcasts";
    configDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/audiobookshelf";
    };
    url = lib.mkOption {
      type = lib.types.strMatching "[a-zA-Z0-9]+(\.[a-zA-Z0-9])*";
      default = "books.${homelab.baseDomain}";
    };
    host = lib.mkOption {
      type = lib.types.strMatching "[a-zA-Z0-9]+(\.[a-zA-Z0-9])*";

      default = "127.0.0.1";
    };
    port = lib.mkOption {
      type = lib.types.int;
      default = 8000;
    };
    homepage = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "Audiobookshelf";
      };
      description = lib.mkOption {
        type = lib.types.str;
        default = "Self hosted server for e-books, audiobooks and podcasts";
      };
      icon = lib.mkOption {
        type = lib.types.str;
        default = "audiobookshelf.svg";
      };
      category = lib.mkOption {
        type = lib.types.str;
        default = "Media";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.audiobookshelf = {
      enable = true;
      user = homelab.user;
      group = homelab.group;
      host = cfg.host;
      port = cfg.port;
      openFirewall = true;
    };
    services.caddy.virtualHosts."${cfg.url}" = {
      # useACMEHost = homelab.baseDomain;
      extraConfig = ''
        reverse_proxy http://127.0.0.1:${toString cfg.port}
      '';
    };
  };
}
