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
        thunar = {
          enable = true;
          plugins = with pkgs.xfce; [
            thunar-volman
            thunar-vcs-plugin
            thunar-archive-plugin
            thunar-media-tags-plugin
          ];
        };
      };

      environment.systemPackages = with pkgs; [
        # Desktop
        # rofi
        feh
        loupe
        nautilus
        nwg-drawer
        pkgs-unstable.pcmanfm
        rofi-wayland
        wofi
        inputs.zen-browser.packages."${system}".default

        # terminal
        pkgs-unstable.alacritty
        kitty
        pkgs-unstable.ghostty

        # widgets
        pkgs-unstable.quickshell
      ];
    })
    {
      programs = {
        yazi.enable = true;
        zsh.enable = true;
      };

      environment.systemPackages = with pkgs; [
        bash
        tdf
        ffmpeg
        grim
      ];
    }
  ];
}
