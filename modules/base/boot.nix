{ config, lib, ... }:

let
  cfg = config.modules.base.bootLoader;
in
{
  options.modules.base.bootLoader = {
    enable = lib.mkEnableOption "bootLoader";
  };

  config = lib.mkIf cfg.enable {
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
