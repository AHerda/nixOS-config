{ pkgs, pkgs-unstable, user, ... }:

{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "copypath"
        "docker"
        "encode64"
        "git"
        "history"
        "rust"
        "sudo"
        "themes"
        # "zsh-autosuggestions"
        # "zsh-syntax-highlighting"
      ];
    };
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      l="eza -al";
      ls="eza";
      ll="eza -l";
      cat="bat";
      v="nvim";
      ".."="z ..";
      ssh="kitten ssh";
      update="path=\"$(pwd)\";cd ~/nixos; sudo nix flake update;cd $path";
      rebuild="sudo nixos-rebuild switch --flake ~/nixos";
      rebuild-test="sudo nixos-rebuild test --flake ~/nixos";
    };
    initExtra = ''
      # export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh
      eval "$(zoxide init zsh)"
      eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/themes/my-theme.toml)"
    '';
    # promptInit = "neofetch";
    # sessionVariables.ZSH = "${pkgs.oh-my-zsh}/share/oh-my-zsh";
  };

  home.packages = with pkgs; [
    pkgs-unstable.oh-my-posh
    # oh-my-zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    # zsh
  ];

  home.sessionVariables = {
    ZSH = "${pkgs.oh-my-zsh}/share/oh-my-zsh";
  };
}
