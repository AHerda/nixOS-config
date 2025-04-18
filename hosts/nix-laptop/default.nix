{ user, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  config.modules = {
    base = {
      bootLoader.enable = true;
      networkmanager.enable = true;
      users.${user.userName}.enable = true;
      version = "24.05";
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
      niri.enable = false;
      notifications.enable = true;
      office.enable = true;
      sddm.enable = false;
      virtualisation = {
        enable = false;
        program = "both";
      };
    };
  };
}
