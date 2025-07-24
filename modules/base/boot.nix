{ config, lib, ... }:

let
  cfg = config.modules.base;
in
{
  options.modules.base = {
    bootLoader.enable = lib.mkEnableOption "bootLoader";
    emulatedSystems = {
      enable = lib.mkEnableOption "Enable emulating systems";
      systems = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "List of systems to emulate";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.bootLoader.enable {
      boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    })
    (lib.mkIf cfg.emulatedSystems.enable {
      boot.binfmt.emulatedSystems = cfg.emulatedSystems.systems;
    })
  ];
}
