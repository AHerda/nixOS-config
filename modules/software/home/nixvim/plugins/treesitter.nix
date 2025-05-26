_:

{
    programs.nixvim.plugins.treesitter = {
        enable = true;
        settings = {
            highlight.enable = true;
            auto_install = true;
            ensure_installed = "all";
        };
    };
}
