{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # system monitoring
    btop
    dua     # testing
    dust    # tetsing
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
