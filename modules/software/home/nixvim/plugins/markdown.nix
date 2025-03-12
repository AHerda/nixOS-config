_:

{
    programs.nixvim.plugins.markdown-preview = {
        enable = true;
        settings = {
            auto_start = 1;
            browser =  "zen";
            theme = "dark";
        };
    };
}
