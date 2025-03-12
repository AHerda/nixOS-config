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
                enable = true;
                standalonePlugins = [
                    "nvim-treesitter"
                ];
            };
            byteCompileLua.enable = true;
        };
    };
}
