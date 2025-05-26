{ config, inputs, lib, pkgs, pkgs-unstable, system, ... }:

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
        thunar.enable = true;
      };

      environment.systemPackages = with pkgs; [
        # Desktop
        # rofi
        feh
        libsForQt5.dolphin
        loupe
        nwg-drawer
        pcmanfm
        rofi-wayland
        wofi
        inputs.zen-browser.packages."${system}".default

        # terminal
        pkgs-unstable.alacritty
        kitty
        pkgs-unstable.ghostty
      ];
    })
    {
      programs = {
        yazi.enable = true;
        zsh.enable = true;
      };

      environment.systemPackages = with pkgs; [
        bash
        nushell
        tdf
      ];
    }
  ];
}
