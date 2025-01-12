{ config, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  config.modules = {
    base = {
      networkmanager.enable = true;
    };

    hardware = {
      audio.enable = true;
      bluetooth.enable = true;
      brightness.enable = true;
      touchscreen.enable = true;
      usb.enable = true;
    };

    software = {
      guiApps.enable = true;
      hypr.enable = true;
      notifications.enable = true;
      sddm.enable = true;
      # tmux.enable = true;
    };
  };
}
