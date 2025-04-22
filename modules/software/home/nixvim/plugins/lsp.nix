_:

{
    programs.nixvim.plugins = {
        lsp-format = {
            enable = false;
            lspServersToEnable = "all";
        };

        lsp = {
            enable = true;
            servers = {
                # ccls.enable = true;
                cmake.enable = true;
                clangd.enable = true;
                nixd.enable = true;
                nushell.enable = true;
                rust_analyzer = {
                    enable = true;
                    installCargo = true;
                    installRustc = true;
                };
                tinymist = {
                    enable = true;
                    extraOptions = {
                        offset_encoding = "utf-8";
                    };
                };
            };
        };
    };
}
