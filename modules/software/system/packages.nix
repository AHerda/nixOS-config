{ config, lib, pkgs, pkgs-unstable, ... }:

let
  cfg = config.modules.software.guiApps;
in
{
  options.modules.software.guiApps = {
    enable = lib.mkEnableOption "guiApps";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      programs = {
        firefox.enable = true;
      };

      environment.systemPackages = with pkgs; [
        # Desktop
        # rofi
        rofi-wayland
        wofi
        libsForQt5.dolphin
        feh

        # terminal
        pkgs-unstable.alacritty
        kitty
        pkgs-unstable.ghostty
      ];
    })
    ({
      programs = {
        yazi.enable = true;
        zsh.enable = true;
      };

      environment.systemPackages = with pkgs; [
        bash
        nushell
      ];
    })
  ];
}
