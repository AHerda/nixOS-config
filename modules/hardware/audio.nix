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
    services.pulseaudio.enable = true;

    security.rtkit.enable = true;
    services.pipewire = {
      enable = false;
      audio.enable = true;
      alsa.enable = true;
      pulse.enable = true;
      wireplumber = {
        enable = true;
      };
    };
  };
}
