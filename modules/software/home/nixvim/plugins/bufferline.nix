_:

{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<M-h>";
        action = "<cmd>BufferLineMovePrev<cr>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<M-l>";
        action = "<cmd>BufferLineMoveNext<cr>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<S-h>";
        action = "<cmd>BufferLineCyclePrev<cr>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<S-l>";
        action = "<cmd>BufferLineCycleNext<cr>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>b<S-d>";
        action = "<cmd>BufferLineCloseOthers<cr>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>br";
        action = "<cmd>BufferLineCloseRight<cr>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>bl";
        action = "<cmd>BufferLineCloseLeft<cr>";
        options.silent = true;
      }
    ];

    plugins.bufferline = {
      enable = true;
    };
  };
}

