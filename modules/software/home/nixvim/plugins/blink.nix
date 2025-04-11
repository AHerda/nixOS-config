_:

{
    programs.nixvim.plugins.blink-cmp = {
        enable = true;
        settings = {
            sources.default = [
                "lsp"
                "path"
                "snippets"
                "buffer"
            ];
            keymap = {
                preset = "enter";
            };
        };
    };
}
