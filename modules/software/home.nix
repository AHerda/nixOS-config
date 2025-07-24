{ inputs, config, lib, pkgs-unstable, hostname, user, ... }:

let
  cfg = config.modules.software.home-manager;
  usersCfg = config.modules.base.users;
  getUserFile = userName: lib.mkIf usersCfg.${userName}.enable {
    ${userName} = import ./home/${userName}.nix;
  };
in {
  options.modules.software.home-manager.enable = lib.mkEnableOption "Home manager";
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  config = {
    home-manager = lib.mkIf cfg.enable {
      users = lib.mkMerge [
        (getUserFile user.userName)
      ];

      useGlobalPkgs = true;
      useUserPackages = true;

      extraSpecialArgs = {
        inherit inputs pkgs-unstable;
        inherit hostname user;

        version = config.modules.base.version;
      };
    };
  };
}
