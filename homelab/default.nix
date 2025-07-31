{ config, lib, ... }:

let
  cfg = config.homelab;
in {
  options.homelab = {
    enable = lib.mkEnableOption "The homelab services and configuration variables";
    user = lib.mkOption {
      default = "share";
      type = lib.types.str;
      description = "User to run the homelab services as";
    };
    group = lib.mkOption {
      default = "share";
      type = lib.types.str;
      description = "Group to run the homelab services as";
    };
  };

  imports = [
    ./services
  ];

  config = lib.mkIf cfg.enable {
    users = {
      users.${cfg.user} = {
        uid = 994;
        isSystemUser = true;
        group = cfg.group;
      };
      groups.${cfg.group} = {
        gid = 993;
      };
    };
  };
}
