{ pkgs, pkgs-unstable, ... }:

{
  programs = {
    firefox.enable = true;
    yazi.enable = true;
    zsh.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Desktop
    rofi
    wofi
    libsForQt5.dolphin
    feh

    # terminal
    pkgs-unstable.alacritty
    kitty

    # shell
    bash
    nushell
    # zsh
  ];
}
