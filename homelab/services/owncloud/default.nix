{ pkgs, config, lib, ... }:

let
  cfg = config.homelab.services.owncloud;
  homelab = config.homelab;
in {
  options.homelab.services.owncloud = {
    enable = lib.mkEnableOption "Enable ownCloud Infinite Scale - self-hosted cloud storage";
    dataDir = lib.mkOption {
      type = lib.types.path;
      default = "/var/lib/ocis";
      description = "Directory in which ocis data will be stored";
    };
    port = lib.mkOption {
      type = lib.types.int;
      default = 9200;
      description = "Port to which ocis will listen on";
    };
    host = lib.mkOption {
      type = lib.types.str;
      default = "127.0.0.1";
      description = "The host that ocis will listen on";
    };
    url = lib.mkOption {
      type = lib.types.strMatching "[a-zA-Z0-9]+(\\.[a-zA-Z0-9]+)*";
      default = "drive.${homelab.baseDomain}";
      description = "URL to access the ownCloud server";
    };
    homepage = {
      name = lib.mkOption { type = lib.types.str; default = "ownCloud"; };
      description = lib.mkOption { type = lib.types.str; default = "Self-hosted cloud storage"; };
      icon = lib.mkOption { type = lib.types.str; default = "owncloud.svg"; };
      category = lib.mkOption { type = lib.types.str; default = "Services"; };
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.tmpfiles.rules = [ "d ${cfg.dataDir} 0775 ocis ${homelab.group} - -" ];

    services.ocis = {
      enable = true;
      package = pkgs.ocis_5-bin.overrideAttrs (_: rec {
        version = "8.0.1";
        src = pkgs.fetchurl {
          url = "https://github.com/owncloud/ocis/releases/download/v${version}/ocis-${version}-linux-amd64";
          hash = "sha256-Q72RQCdoreS7CTfrBrGyMWAPYhUG0eu3WX1sUyulXeY=";
        };
      });
      environment = {
        OCIS_URL = "https://${cfg.url}";
        PROXY_HTTP_ADDR = "${cfg.host}:${toString cfg.port}";
        PROXY_TLS = "false";
        OCIS_LOG_LEVEL = "warn";
      };
      stateDir = cfg.dataDir;
      configDir = "${cfg.dataDir}/config";
      # environmentFile = "/run/secrets/ocis.env";
    };

    services.caddy.virtualHosts."${cfg.url}".extraConfig = ''
      reverse_proxy http://${cfg.host}:${toString cfg.port}
      tls {
        dns cloudflare {env.CLOUDFLARE_API_TOKEN}
      }
    '';
  };
}
