_:

let
    normal = "n";
    visual = "v";
    all = [ "n" "v" "i" "t" "x" ];
    map = mode: action: key: {
        inherit mode action key;
        options.silent = true;
    };
in
{
    programs.nixvim = {
        globals = {
            mapleader = " ";
            maplocalleader = " ";
        };
        keymaps = [
            (map all "<ESC>" "kj")
            (map all "<ESC>:w<CR>" "<C-s>")
            (map all "<ESC>:q<CR>" "<leader>qq")
            (map normal "<C-w>h" "<C-h>")
            (map normal "<C-w>j" "<C-j>")
            (map normal "<C-w>k" "<C-k>")
            (map normal "<C-w>l" "<C-l>")
        ];
    };
}
