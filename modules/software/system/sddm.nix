{ config, lib, ... }:

let
  cfg = config.modules.software.sddm;
in
{
  options.modules.software.sddm = {
    enable = lib.mkEnableOption "sddm";
  };

  config = lib.mkIf cfg.enable {
    services = {
      xserver.enable = true;
      displayManager = {
        sddm = {
          enable = true;
          wayland.enable = true;
        };
        defaultSession = "hyprland";
      };
    };
  };
}
