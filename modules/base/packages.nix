{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    btop
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
