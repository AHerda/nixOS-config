{ config, lib, pkgs, ... }:
let
  cfg = config.modules.hardware;
in
{
  options.modules.hardware = {
    touch.enable = lib.mkEnableOption "Enable touchscreen";
    display.enable = lib.mkEnableOption "Enable display";
  };

  config = {
    services.iptsd.enable = cfg.touch.enable;
    environment.systemPackages = lib.mkIf cfg.touch.enable [ pkgs.surface-control ];
    boot.kernelParams = lib.mkIf (!cfg.display.enable) [ "video=eDP-1:d" ];
  };
}
