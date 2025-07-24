{ pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs; [
    # cli
    bat
    cava
    eza
    fzf
    pkgs-unstable.jujutsu
    pkgs-unstable.lazyjj
    mprocs
    neofetch
    ripgrep
    zoxide

    # config help
    stow

    # user programs
    # pkgs-unstable.neovim
    lazygit
    typst

    # Applications
    ncspot
    telegram-desktop
    pkgs-unstable.spotify
    brave
    (flameshot.override { enableWlrSupport = true; })
    # pkgs-unstable.obsidian
  ];
}
