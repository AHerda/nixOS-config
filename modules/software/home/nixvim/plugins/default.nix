_:

{
    imports = [
        ./barbar.nix
        ./blink.nix
        ./lazygit.nix
        ./lsp.nix
        ./lualine.nix
        ./markdown.nix
        ./mini.nix
        ./neotree.nix
        ./nix.nix
        ./noice.nix
        ./nui.nix
        ./persistence.nix
        ./snacks.nix
        ./startup.nix
        ./telescope.nix
        ./treesitter.nix
        ./trim.nix
        ./typst.nix
        ./which-key.nix
    ];

    programs.nixvim.plugins = {
        lz-n.enable = true;
        web-devicons.enable = true;
        clangd-extensions.enable = true;
    };
}
