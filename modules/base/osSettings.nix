{ config, lib, system, ... }:

let
  cfg = config.modules.base;
in
{
  options.modules.base = {
    version = lib.mkOption {
      type = lib.types.strMatching "[0-9]{2}\.[0-9]{2}";
      description = "System state version";
    };
    # system = lib.mkOption {
    #   type = lib.types.str;
    #   description = "System type";
    # };
  };

  config = {
    system.stateVersion = cfg.version;

    environment.variables = {
        EDITOR = "vim";
        NIXOS_OZONE_WL=1;
    };

    nixpkgs.hostPlatform = system; # idk if even correct
  };
}
