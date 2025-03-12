{ user, version, ... }:

{
  imports = [
    ./nixvim
    ./dotfiles.nix
    ./git.nix
    ./packages.nix
    ./tmux.nix
    ./zsh.nix
  ];

  home = {
    username = user.userName;
    homeDirectory = "/home/${user.userName}";

    stateVersion = version;
  };

  programs.home-manager.enable = true;
}
