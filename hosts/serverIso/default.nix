{ config, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  # config.nixpkgs.hostPlatform = "x86_64-linux";

  config.modules = {
    hardware = {
      audio.enable = true;
      bluetooth.enable = true;
      brightness.enable = true;
      usb.enable = true;
    };
  };
}
