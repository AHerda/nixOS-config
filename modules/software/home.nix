{ inputs, config, lib, pkgs-unstable, hostname, user, ... }:

let
  usersCfg = config.modules.base.users;
  getUserFile = userName: lib.mkIf usersCfg.${userName}.enable {
    ${userName} = import ./home/${userName}.nix;
  };
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    users = lib.mkMerge [
      (getUserFile user.userName)
    ];

    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = {
      inherit pkgs-unstable;
      inherit hostname user;

      version = config.modules.base.version;
    };
  };
}
