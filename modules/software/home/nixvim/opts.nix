_:

{
    programs.nixvim = {
        opts = {
            number = true;
            relativenumber = true;

            tabstop = 4;
            shiftwidth = 4;
            expandtab = true;
            autoindent = true;

            timeoutlen = 300;
        };
    };
}
