{ pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs; [
    # cli
    bat
    cava
    eza
    fzf
    neofetch
    ripgrep
    zoxide

    # config help
    stow

    # user programs
    pkgs-unstable.neovim
    lazygit
    pkgs-unstable.ollama

    # Applications
    telegram-desktop
    pkgs-unstable.spotify
  ];
}
