_:

{
    programs.nixvim.plugins.barbar = {
        enable = true;
        keymaps = {
            close.key = "<leader>bd";
            closeAllButCurrentOrPinned.key = "<leader>b<S-d>";
            closeBuffersLeft.key = "<leader>bl";
            closeBuffersRight.key = "<leader>br";
            next.key =  "<S-l>";
            pin.key =  "<leader>bp";
            previous.key = "<S-h>";
        };
        settings = {
            animation = true;
            clickable = true;
            sidebar_filetypes = {
                neo-tree = true;
                NvimTree = true;
            };
        };
    };
}
