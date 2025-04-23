_:

{
    programs.nixvim.plugins.telescope = {
        enable = true;
        keymaps = {
            "<leader>f<space>" = "find_files";
            "<leader>/" = "live_grep";
        };
    };
}
