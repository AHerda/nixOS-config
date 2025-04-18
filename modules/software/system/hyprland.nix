{ config, lib, pkgs, ... }:

let
  cfg = config.modules.software.hypr;
in
{
  options.modules.software.hypr = {
    enable = lib.mkEnableOption "hypr";
  };

  config = lib.mkIf cfg.enable {
    # configure hyprland
    programs = {
      hyprland = {
        enable = true;
        xwayland.enable = true;
      };
      hyprlock.enable = true;
      waybar.enable = true;
    };
    services.hypridle.enable = true;

    environment.systemPackages = with pkgs; [
      # hyprlock
      # hypridle
      hyprpaper
      # waybar
      wl-clipboard
    ];
  };
}
