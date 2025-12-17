{ pkgs, pkgs-unstable, config, osConfig, lib, user, ... }:

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

        fd = {
          enable = true;
          hidden = true;
        };

        fzf = {
          enable = true;
          # enableNushellIntegration = true;
          enableZshIntegration = true;
        };

        jujutsu = {
          enable = true;
          ediff = true;

          settings = {
            user.email = "${user.userEmail}";
            user.name = "${user.fullName}";
            ui.default-command = "st";
          };
        };

        lazygit = {
          enable = true;
          # uncomment it when the settings will correctly write config
          # settings.git.pagers.externalDiffCommand = "difft --color=always";
        };

        oh-my-posh = {
          enable = true;
          enableZshIntegration = true;
          enableNushellIntegration = true;
          configFile = "~/.config/oh-my-posh/themes/my-theme.toml";
          package = pkgs-unstable.oh-my-posh;
        };

        ripgrep.enable = true;

        starship = {
          enable = true;
          enableNushellIntegration = false;
          enableInteractive = false;
          enableTransience = true;
        };

        yazi = {
          enable = true;
          enableZshIntegration = true;
          enableNushellIntegration = true;
          settings = {
            flavor.dark = "gruvbox";
            opener = {
              forPictures = [{
                run = "loupe \"$0\"";
                block = true;
                for = "unix";
              }];
            };
            open.prepend_rules = [
              {
                mime = "image/*";
                use = "forPictures";
              }
            ];
          };
        };

        zellij = {
          enable = true;
          attachExistingSession = true;
          exitShellOnExit = true;
          settings = {
            theme = "gruvbox-dark";
          };
        };

        zoxide = {
          enable = true;
          enableZshIntegration = true;
          enableNushellIntegration = true;
        };
      };

      home.packages = with pkgs; [
        # cli
        pkgs-unstable.lazyjj
        mprocs
        neofetch

        #  config help
        stow
        pywal

        # user programs
        # pkgs-unstable.neovim
        typst

        # Applications
        ncspot
      ];
    }

    (lib.mkIf cfg.enable {
      home.packages = with pkgs; [
        # Gui Apps
        telegram-desktop
        pkgs-unstable.spotify
        brave
        pkgs-unstable.obsidian

        # editors
        zed-editor

        # for flameshot
        xdg-desktop-portal
        xdg-desktop-portal-wlr
      ];

      services.flameshot = {
        enable = true;
        package = pkgs-unstable.flameshot.override {
          enableWlrSupport = true;
        };
        settings.General = {
          disabledTrayIcon = true;
          showStartupLaunchMessage = false;

          # Copy path
          savePath = "${config.home.homeDirectory}/Pictures/screenshots";
          savePathFixed = true;
          saveAsFileExtension = ".jpg";
          filenamePattern = "%F_%H-%M";
          drawThickness = 1;
          copyPathAfterSave = true;


          # For wayland
          disabledGrimWarning = true;
          useGrimAdapter = true;
        };
      };

      programs.fuzzel = {
        enable = true;
        settings = {
          main = {
            terminal = "${pkgs.ghostty}/bin/ghostty -e";
            layer = "overlay";
            # dpi-aware = "yes";
            icon-theme = "Papirus-Dark";
            width = 45;
            horizontal-pad = 8;
            font = "JetBrains Mono:size=12";
            line-height = 18;
            lines = 25;
            prompt = "❯   ";
            show-actions = "yes";
            launch-prefix = "uwsm app --";
          };
          colors = {
            background = "282828fa";
            text = "ebdbb2fa";
            selection-text = "ebdbb2fa";
            prompt = "ebdbb2fa";
            input = "ebdbb2fa";
            selection = "504945fa";
            border = "fbf1c7fa";
            match = "d65e0dfa";
            selection-match = "d65e0dfa";
          };
          border =  {
            radius = 20;
            width = 5;
          };
        };
      };
    })
  ];
}
