{ ... }:

{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    historyLimit = 10000;
    plugins = [
      # add something later
    ];
  };
}
