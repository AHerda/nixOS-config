{ config, modulesPath, system, ... }:

{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  config.nixpkgs.hostPlatform = system;

  config.modules = {
    hardware = {
      audio.enable = true;
      bluetooth.enable = true;
      brightness.enable = true;
      usb.enable = true;
    };
  };
}
