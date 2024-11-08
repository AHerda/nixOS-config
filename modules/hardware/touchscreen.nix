{ config, lib, pkgs, ... }:
let
  cfg = config.modules.hardware.touchscreen;
in
{
  options.modules.hardware.touchscreen = {
    enable = lib.mkEnableOption "touchscreen";
  };

  config = lib.mkIf cfg.enable {
    services.iptsd.enable = true;
    environment.systemPackages = [ pkgs.surface-control ];
  };
}
