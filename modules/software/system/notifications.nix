{ config, lib, pkgs, ... }:

let
  cfg = config.modules.software.notifications;
in
{
  options.modules.software.notifications = {
    enable = lib.mkEnableOption "notifications";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
        pkgs.swaynotificationcenter
        pkgs.libnotify
    ];
  };
}
