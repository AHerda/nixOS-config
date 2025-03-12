_:

{
    programs.nixvim.plugins.trim = {
        enable = true;
        settings = {
            ft_blocklist = [ "neo-tree" "NeoTree" ];
            highlight = false;
            trim_last_line = false;
        };
    };
}
