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
      pkgs.pavucontrol
    ];
    hardware.pulseaudio.enable = true;
    services.pipewire.audio.enable = false;
    services.pipewire.enable = false;
  };
}
