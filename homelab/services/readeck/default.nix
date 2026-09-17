{ config, lib, ... }:

let
  cfg = config.homelab.services.readeck;
  homelab = config.homelab;
in {
  options.homelab.services.readeck = {
    enable = lib.mkEnableOption "Enable readeck - self-hosted a bookmarking page";
    dataDir = lib.mkOption {
      type = lib.types.path;
      default = "/var/lib/readeck";
      description = "Directory in which readeck data will be stored";
    };
    port = lib.mkOption {
      type = lib.types.int;
      description = "Port to which readeck will listen to";
      default = 8888;
    };
    host = lib.mkOption {
      default = "localhost";
      type = lib.types.str;
      description = "The host that readeck will listen on";
    };
    url = lib.mkOption {
      type = lib.types.strMatching "[a-zA-Z0-9]+(\\.[a-zA-Z0-9]+)*";
      description = "Url to enter the readeck server";
      default = "readeck.${homelab.baseDomain}";
    };
    environmentFile = lib.mkOption {
      type = lib.types.path;
      description = "File containing READECK_SECRET_KEY, kept out of the nix store";
      default = "/etc/secrets/readeck.env";
    };
    homepage = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "Readeck";
      };
      description = lib.mkOption {
        type = lib.types.str;
        default = "Self-hosted memo hub and note-taking tool";
      };
      icon = lib.mkOption {
        type = lib.types.str;
        default = "readeck.svg";
      };
      category = lib.mkOption {
        type = lib.types.str;
        default = "Services";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    # networking.firewall.allowedTCPPorts = lib.mkIf cfg.open[ cfg.port ];
    services.readeck = {
      enable = true;
      environmentFile = cfg.environmentFile;
      settings = {
        server = {
          host = cfg.host;
          port = cfg.port;
        };
      };
    };
    services.caddy.virtualHosts."${cfg.url}".extraConfig = ''
      reverse_proxy http://${cfg.host}:${toString cfg.port}
      tls {
        dns cloudflare {env.CLOUDFLARE_API_TOKEN}
      }
    '';
  };
}
