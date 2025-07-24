_:

let
    normal = "n";
    visual = "v";
    all = [ "n" "v" "i" "t" "x" ];
    map = mode: action: key: desc: {
        inherit mode action key;
        options = {
            inherit desc;
            silent = true;
        };
    };
in
{
    programs.nixvim = {
        globals = {
            mapleader = " ";
            maplocalleader = " ";
        };
        keymaps = [
            (map all "<ESC>" "kj" "Escape")
            (map all "<ESC>:w<cr>" "lkjh" "Save file")
            (map all "<ESC>:w<cr>" "<C-s>" "Save file")
            (map all "<ESC>:qa<cr>" "<leader>qq" "Exit session")
            (map all "<ESC>:q<cr>" "<leader>qw" "Exit window")
            (map normal "<C-w>h" "<C-h>" "Tab Left")
            (map normal "<C-w>j" "<C-j>" "Tab Down")
            (map normal "<C-w>k" "<C-k>" "Tab Up")
            (map normal "<C-w>l" "<C-l>" "Tab Right")
        ];
    };
}
