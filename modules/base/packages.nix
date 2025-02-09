{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    btop
    usbutils
    curl
    git
    htop
    killall
    mc
    tree
    unzip
    vim
    wget
  ];
}
