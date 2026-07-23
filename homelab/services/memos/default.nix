{ config, lib, ... }:

let
  cfg = config.homelab.services.memos;
  homelab = config.homelab;
in {
  options.services.memos.port = lib.mkOption {
    type = lib.types.int;
    default = cfg.port;
    description = "Port to which memos will listen to";
  };
  options.homelab.services.memos = {
    enable = lib.mkEnableOption "Enable memos - self-hosted memo hub and note-taking solution";
    dataDir = lib.mkOption {
      type = lib.types.path;
      default = "/var/lib/memos";
      description = "Directory in which memos data will be stored";
    };
    port = lib.mkOption {
      type = lib.types.int;
      default = 5230;
      description = "Port to which memos will listen to";
    };
    host = lib.mkOption {
      default = "localhost";
      type = lib.types.str;
      description = "The host that memos will listen on";
    };
    url = lib.mkOption {
      type = lib.types.strMatching "[a-zA-Z0-9]+(\\.[a-zA-Z0-9]+)*";
      description = "Url to enter the memos server";
      default = "memos.${homelab.baseDomain}";
    };
    homepage = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "Memos";
      };
      description = lib.mkOption {
        type = lib.types.str;
        default = "Self-hosted memo hub and note-taking tool";
      };
      icon = lib.mkOption {
        type = lib.types.str;
        default = "memos.svg";
      };
      category = lib.mkOption {
        type = lib.types.str;
        default = "Services";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.memos = {
      enable = true;
      openFirewall = true;
      dataDir = "${cfg.dataDir}";
      group = "${homelab.group}";
      settings = {
        MEMOS_MODE = "prod";
        MEMOS_ADDR = "${cfg.host}";
        MEMOS_PORT = "${toString cfg.port}";
        MEMOS_DATA = config.services.memos.dataDir;
        MEMOS_DRIVER = "sqlite";
        MEMOS_INSTANCE_URL = "http://localhost:${toString cfg.port}";
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
