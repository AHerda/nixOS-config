_:

{
  programs.nixvim.plugins.startup = {
    enable = true;

    colors = {
      background = "#ffffff";
      foldedSection = "#ffffff";
    };

    sections = {
      header = {
        type = "text";
        oldfilesDirectory = false;
        align = "center";
        foldSection = false;
        title = "Header";
        margin = 5;
        content = [
            "      ___      _______   __  ____    ____ __ .___  ___. "
            "     /   \\    |       \\ |  | \\   \\  /   /|  ||   \\/   | "
            "    /  ^  \\   |  .--.  ||  |  \\   \\/   / |  ||  \\  /  | "
            "   /  /_\\  \\  |  |  |  ||  |   \\      /  |  ||  |\\/|  | "
            "  /  _____  \\ |  '--'  ||  |    \\    /   |  ||  |  |  | "
            " /__/     \\__\\|_______/ |__|     \\__/    |__||__|  |__| "
            "                                                         "
        ];
        highlight = "Statement";
        defaultColor = "";
        oldfilesAmount = 0;
      };

      body = {
        type = "mapping";
        oldfilesDirectory = false;
        align = "center";
        foldSection = false;
        title = "Menu";
        margin = 5;
        content = [
          [
            "  Find File"
            "Telescope find_files"
            "f"
          ]
          [
            "󰍉  Find Word"
            "Telescope live_grep"
            "g"
          ]
          [
            "  Restore Session"
            "lua require('persistence').load()"
            "s"
          ]
          [
            "  Recent Files"
            "Telescope oldfiles"
            "r"
          ]
          [
            "  File Browser"
            "Telescope file_browser"
            "b"
          ]
          [
            "  Edit Configurations"
            "edit ~/nixos/modules/software/home/nixvim/default.nix"
            "cg"
          ]
          [
            "  Quit Neovim"
            "q"
            "q"
          ]
        ];
        highlight = "string";
        defaultColor = "";
        oldfilesAmount = 0;
      };
    };

    options = {
      paddings = [
        1
        3
      ];
    };

    parts = [
      "header"
      "body"
    ];
  };
}
