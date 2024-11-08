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

    # terminal
    pkgs-unstable.alacritty
    kitty

    # developmet
    cmake
    gcc
    gnumake
    python3
    rustup

    # shell
    bash
    nushell
    # zsh
  ];
}
