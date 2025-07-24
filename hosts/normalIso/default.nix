{ config, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-calamares.nix"
  ];

  # config.nixpkgs.hostPlatform = system;

  config.modules = {
    base = {
        networkmanager.enable = true;
    };

    hardware = {
      audio.enable = true;
      bluetooth.enable = true;
      brightness.enable = true;
      usb.enable = true;
    };

    software = {
      hypr.enable = true;
      notifications.enable = true;
    };
  };
}
