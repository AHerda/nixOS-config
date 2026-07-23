{ config, lib, ... }:

let
  cfg = config.homelab.services.vaultwarden;
  homelab = config.homelab;
in {
  options.homelab.services.vaultwarden = {
    enable = lib.mkEnableOption "Self hosted server for e-books, audiobooks and podcasts";
    host = lib.mkOption {
      type = lib.types.str;
      default = "127.0.0.1";
      description = "The host that vaultwarden will listen on";
    };
    port = lib.mkOption {
      type = lib.types.int;
      default = 8222;
    };
    url = lib.mkOption {
      type = lib.types.strMatching "[a-zA-Z0-9]+(\\.[a-zA-Z0-9]+)*";
      default = "pass.${homelab.baseDomain}";
    };
    homepage = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "Vaultwarden";
      };
      description = lib.mkOption {
        type = lib.types.str;
        default = "Self hosted password management tool";
      };
      icon = lib.mkOption {
        type = lib.types.str;
        default = "vaultwarden.svg";
      };
      category = lib.mkOption {
        type = lib.types.str;
        default = "Services";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.vaultwarden = {
      enable = true;
      environmentFile = "/etc/secrets/vaultwarden.env";
      config = {
        DOMAIN = "https://${cfg.url}";
        SIGNUPS_ALLOWED = false;
        ROCKET_ADDRESS = cfg.host;
        ROCKET_PORT = cfg.port;
        EXTENDED_LOGGING = true;
        LOG_LEVEL = "warn";
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

