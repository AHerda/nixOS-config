{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # system monitoring
    btop
    glances
    htop
    procs

    dua     # testing
    dust    # tetsing

    nix-index
    tree

    # system managing
    killall
    mc

    # VCS
    git

    # VIProgramms
    curl
    usbutils
    unzip
    vim
    wget
  ];
}
