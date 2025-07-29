{ pkgs, pkgs-unstable, osConfig, lib, ... }:

let
  cfg = osConfig.modules.software.guiApps;
in {
  config = lib.mkMerge [
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

        #  config help
        stow

        # user programs
        # pkgs-unstable.neovim
        lazygit
        typst

        # Applications
        ncspot
        # pkgs-unstable.obsidian
      ];
    }
    (lib.mkIf cfg.enable {
      home.packages = with pkgs; [
	# Gui Apps
        telegram-desktop
        pkgs-unstable.spotify
        brave
        (flameshot.override { enableWlrSupport = true; })
      ];
    })
  ];
}
