_:

{
  programs.nixvim.plugins.grug-far = {
    enable = true;
    settings = {
      engine = "ripgrep";
      engines.ripgrep = {
        path = "rg";
        showReplaceDiff = true;
      };
    };
  };
}
