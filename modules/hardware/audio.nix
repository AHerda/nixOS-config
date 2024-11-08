{ config, pkgs, lib, ... }:

let
  cfg = config.modules.hardware.audio;
in
{
  options.modules.hardware.audio = {
    enable = lib.mkEnableOption "audio";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.pulseaudio-ctl
      pkgs.libinput
    ];
    hardware.pulseaudio.enable = true;
  };
}
