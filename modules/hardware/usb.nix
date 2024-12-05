{ config, lib, ... }:

let
  cfg = config.modules.hardware.usb;
in
{
  options.modules.hardware.usb = {
    enable = lib.mkEnableOption "usb";
  };

  config = lib.mkIf cfg.enable {
    services.devmon.enable = true;
    services.gvfs.enable = true;
    services.udisks2.enable = true;
  };
}
