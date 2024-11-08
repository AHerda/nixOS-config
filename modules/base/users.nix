{ config, lib, pkgs, user, ... }:

{
  users.defaultUserShell = pkgs.bash;

  users.users.${user.userName} = {
    isNormalUser = true;
    description = user.fullName;
    extraGroups = [
      "audio"
      "media"
      "networkmanager"
      "surface-control"
      "wheel"
      "video"
    ];
    shell = pkgs.zsh;
    # ignoreShellProgramCheck = true;
  };
}
