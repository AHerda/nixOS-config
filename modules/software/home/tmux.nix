{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    historyLimit = 100000;

    plugins = with pkgs.tmuxPlugins; [
      catppuccin
      continuum
      fzf-tmux-url
      resurrect
      sensible
      tmux-fzf
      tmux-thumbs
    ];
  };
}
