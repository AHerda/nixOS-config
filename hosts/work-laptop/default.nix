{ inputs, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14
  ];

  config.modules = {
    base = {
      bootLoader.enable = true;
      networkmanager.enable = true;
      users.${user.userName}.enable = true;
      proxy = {
        enable = true;
        url = "http://10.158.100.1:8080";
        noProxyUrls = "127.0.0.0/8, localhost, .nokia.net, .nsn-net.net, .nsn-rdnet.net, .ext.net.nokia.com, .int.net.nokia.com, .inside.nsn.com, .inside.nokiasiemensnetworks.com, .emea.nsn-net.net, .nesc.nokia.net, 192.168.49.2";
      };
      version = "24.11"; # version at which this machine started, dont change
      security.doas = true;
    };

    hardware = {
      audio.enable = true;
      bluetooth.enable = true;
      brightness.enable = true;
      touchscreen.enable = false;
      usb.enable = true;
    };

    software = {
      guiApps.enable = true;
      hypr.enable = true;
      notifications.enable = true;
      office.enable = true;
      sddm.enable = false;
      workPackages.enable = true;
      virtualisation = {
        enable = true;
        program = "both";
      };
    };
  };
}
