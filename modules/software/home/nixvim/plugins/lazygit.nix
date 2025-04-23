_:

{
    programs.nixvim = {
        plugins.lazygit = {
            enable = true;
        };
        # keymaps = [
        #     {
        #         mode = "n";
        #         action = "<cmd>LazyGit<cr>";
        #         key = "<leader>gg";
        #         options.silent = true;
        #         options.desc = "Open LazyGit";
        #     }
        # ];
    };
}
