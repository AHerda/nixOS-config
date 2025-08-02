{ config, lib, ... }:

let
  cfg = config.homelab.services.immich;
  homelab = config.homelab;
  services = config.homelab.services;
in {
  options.homelab.services.immich = {
    enable = lib.mkEnableOption "Enable immich - self-hosted photo and video management solution";
    mediaDir = lib.mkOption {
      type = lib.types.path;
      default = /var/lib/immich;
      description = "Directory in which the media will be stored";
    };
    port = lib.mkOption {
      type = lib.types.int;
      default = 2283;
      description = "Port to which immich will listen to";
    };
  };

  config = lib.mkIf cfg.enable {
    services.immich = {
      enable = true;
      # mediaLocation = "${cfg.mediaDir}";
      port = cfg.port;
    };
    users.users.immich.extraGroups = [
      "video"
      "render"
    ];
  };
}
