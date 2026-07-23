{ config, lib, pkgs, ... }:

let
  cfg = config.homelab.services.nextcloud;
  homelab = config.homelab;
in {
  options.homelab.services.nextcloud = {
    enable = lib.mkEnableOption "Enable Nextcloud - self-hosted cloud storage";
    dataDir = lib.mkOption {
      type = lib.types.path;
      default = "/var/lib/nextcloud";
      description = "Directory in which Nextcloud data will be stored";
    };
    port = lib.mkOption {
      type = lib.types.int;
      default = 8080;
      description = "Internal port Nextcloud will listen on";
    };
    url = lib.mkOption {
      type = lib.types.strMatching "[a-zA-Z0-9]+(\\.[a-zA-Z0-9]+)*";
      default = "cloud.${homelab.baseDomain}";
      description = "URL to access the Nextcloud server";
    };
    adminPasswordFile = lib.mkOption {
      type = lib.types.path;
      default = "/etc/secrets/nextcloud-admin-pass";
      description = "Path to file containing the admin password";
    };
    homepage = {
      name = lib.mkOption { type = lib.types.str; default = "Nextcloud"; };
      description = lib.mkOption { type = lib.types.str; default = "Self-hosted cloud storage"; };
      icon = lib.mkOption { type = lib.types.str; default = "nextcloud.svg"; };
      category = lib.mkOption { type = lib.types.str; default = "Services"; };
    };
  };

  config = lib.mkIf cfg.enable {
    services.nextcloud = {
      enable = true;
      package = pkgs.nextcloud33;
      hostName = cfg.url;
      datadir = cfg.dataDir;
      https = true;
      maxUploadSize = "10G";

      config = {
        adminpassFile = cfg.adminPasswordFile;
        dbtype = "pgsql";
        dbhost = "/run/postgresql";
        dbname = "nextcloud";
        dbuser = "nextcloud";
      };

      settings = {
        trusted_proxies = [ "127.0.0.1" ];
        overwriteprotocol = "https";
        "overwrite.cli.url"  = "https://cloud.homelab.aherda.com/";
        log_type = "file";
        loglevel = 2;
      };

      phpOptions = {
        "opcache.interned_strings_buffer" = "23";
      };
    };

    services.postgresql = {
      enable = true;
      ensureDatabases = [ "nextcloud" ];
      ensureUsers = [{
        name = "nextcloud";
        ensureDBOwnership = true;
      }];
    };

    systemd.services."nextcloud-setup" = {
      requires = [ "postgresql.service" ];
      after = [ "postgresql.service" ];
    };

    services.nginx.virtualHosts."${cfg.url}" = {
      listen = [{ addr = "127.0.0.1"; port = cfg.port; }];
    };

    services.caddy.virtualHosts."${cfg.url}".extraConfig = ''
      reverse_proxy http://127.0.0.1:${toString cfg.port}
      tls {
        dns cloudflare {env.CLOUDFLARE_API_TOKEN}
      }
    '';
  };
}
