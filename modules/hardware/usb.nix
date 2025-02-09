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

      services.udev.extraRules = ''
        ACTION=="add",
        SUBSYSTEM=="usb",
        ATTR{idVendor}=="0bda",
        ATTR{idProduct}=="8153",
        ATTR{power/autosuspend}=="20"
      '';
  };
}
