_:

{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>NvimTreeFindFileToggle<cr>";
        options = {
          silent = true;
          desc = "Toggle Tree view";
        };
      }
      {
        mode = "n";
        key = "<leader>E";
        action = "<cmd>NvimTreeToggle<cr>";
        options = {
          silent = true;
          desc = "Open Tree view without focusing on current buffer";
        };
      }
    ];
    plugins.nvim-tree = {
      enable = true;

      autoClose = true;
      ignoreBufferOnSetup = true;
      # autoLoad = true;
      # settings.options = {
      #   tab.sync.close = true;
      # };
    };
  };
}
