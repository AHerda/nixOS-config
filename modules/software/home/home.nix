{ user, version, ... }:

{
  imports = [
    ./dotfiles.nix
    ./git.nix
    # ./nvim.nix
    ./zsh.nix
    ./packages.nix
  ];

  home = {
    username = user.userName;
    homeDirectory = "/home/${user.userName}";

    stateVersion = version;
  };

  programs.home-manager.enable = true;
}
