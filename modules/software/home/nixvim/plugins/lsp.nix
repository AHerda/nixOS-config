_:

{
    programs.nixvim.plugins = {
        lsp-format = {
            enable = true;
            lspServersToEnable = "all";
        };

        lsp = {
            enable = true;
            servers = {
                cmake.enable = true;
                clangd.enable = true;
                nil_ls.enable = true;
            };
        };
    };
}
