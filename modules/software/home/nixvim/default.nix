{ inputs, ... }:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
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
