{ inputs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./colorschemes.nix
    ./keymaps.nix
    ./opts.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;

    defaultEditor = true;
    performance = {
      combinePlugins = {
        enable = false;
        standalonePlugins = [
          "nvim-treesitter"
          "oil"
          "blink"
        ];
      };
      byteCompileLua.enable = true;
    };
  };
}
