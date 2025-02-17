{ config, lib, ... }:

let
  cfg = config.modules.base.version;
in
{
  options.modules.base.version = lib.mkOption {
    type = lib.types.strMatching "[0-9]{2}\.[0-9]{2}";
    description = "System state version";
  };

  config = {
    system.stateVersion = cfg;

    environment.variables = {
        EDITOR = "vim";
        NIXOS_OZONE_WL=1;
    };
  };
}
