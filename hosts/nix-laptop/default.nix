{ config, ... }:

{
  imports = [
    ./hardware-configuration.nix    
  ];

  config.modules = {
    hardware = {
      audio.enable = true;
      bluetooth.enable = true;
      brightness.enable = true;
      touchscreen.enable = true;
      usb.enable = true;
    };
  };
}
