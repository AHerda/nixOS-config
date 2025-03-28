{ config, pkgs, lib, ... }:

let
  cfg = config.modules.hardware.bluetooth;
in
{
  options.modules.hardware.bluetooth = {
    enable = lib.mkEnableOption "bluetooth";
  };

  config = lib.mkIf cfg.enable {
    hardware.bluetooth.enable = true;
    environment.systemPackages = [
      pkgs.blueman
      pkgs.bluez
    ];
  };
}
