{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # system monitoring
    btop
    htop
    nix-index
    tree

    # system managing
    killall
    mc

    # VIProgramms
    curl
    git
    usbutils
    unzip
    vim
    wget
  ];
}
