{ config, lib, pkgs, user, ... }:

let
  cfg = config.modules.base.users;
  name = user.userName;
in
{
  options.modules.base.users.${name} = {
    enable = lib.mkEnableOption "${name}";
  };


  config = lib.mkMerge [
    ({
      users.defaultUserShell = pkgs.bash;
    })
    (lib.mkIf cfg.${name}.enable {
      users.users.${name} = {
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
      };
    })
  ];
}
