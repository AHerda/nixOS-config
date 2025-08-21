{ pkgs, pkgs-unstable, config, osConfig, lib, ... }:

let
  cfg = osConfig.modules.software.guiApps;
in {
  config = lib.mkMerge [
    {
      programs = {
        atuin = {
          enable = true;
          enableZshIntegration = true;
          enableNushellIntegration = true;
        };

        bat.enable = true;

        carapace = {
          enable = true;
          enableZshIntegration = true;
          enableNushellIntegration = true;
        };

        cava.enable = true;

        eza = {
          enable = true;
          enableZshIntegration = true;
          enableNushellIntegration = false;
          icons = "auto";
          git = true;
        };

        jujutsu = {
          enable = true;
          ediff = true;
        };

        lazygit.enable = true;

        oh-my-posh = {
          enable = true;
          enableZshIntegration = true;
          enableNushellIntegration = true;
          # settings = builtins.fromTOML (builtins.unsafeDiscardStringContext (builtins.readFile "${config.home.homeDirectory}/.config/oh-my-posh/themes/my-theme.toml"));
          package = pkgs-unstable.oh-my-posh;
        };

        starship = {
          enable = true;
          enableNushellIntegration = false;
          enableInteractive = false;
          enableTransience = true;
        };

        zoxide = {
          enable = true;
          enableZshIntegration = true;
          enableNushellIntegration = true;
        };
      };

      home.packages = with pkgs; [
        # cli
        fzf
        pkgs-unstable.lazyjj
        mprocs
        neofetch
        ripgrep

        #  config help
        stow

        # user programs
        # pkgs-unstable.neovim
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
