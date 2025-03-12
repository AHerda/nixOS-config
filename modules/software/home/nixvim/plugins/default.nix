_:

{
    imports = [
        ./barbar.nix
        ./blink.nix
        ./lsp.nix
        ./lualine.nix
        ./markdown.nix
        ./mini.nix
        ./neotree.nix
        ./noice.nix
        ./nui.nix
        ./snacks.nix
        ./telescope.nix
        ./trim.nix
    ];

    programs.nixvim.plugins = {
        lazygit.enable = true;
        lz-n.enable = true;
        web-devicons.enable = true;
    };
}
