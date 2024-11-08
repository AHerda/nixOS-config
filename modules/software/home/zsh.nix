{ pkgs, user, ... }:

{
  programs.zsh = {
    # enable = true;
    oh-my-zsh.enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      update="sudo nixos-rebuild switch --flake ~/nixos";
    };
    #initExtra = ''
    #  export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh
    #'';
    #promptInit = "neofetch";
    sessionVariables.ZSH = "${pkgs.oh-my-zsh}/share/oh-my-zsh";
  };

  home.packages = with pkgs; [
    oh-my-posh
    # oh-my-zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    # zsh
  ];

  home.sessionVariables = {
    ZSH = "${pkgs.oh-my-zsh}/share/oh-my-zsh";
  };
}
