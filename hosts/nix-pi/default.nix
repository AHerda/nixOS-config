{ inputs, user, ... }:

{
  imports = [
    inputs.nixos-raspberrypi.nixosModules.raspberry-pi-5.base
    inputs.nixos-raspberrypi.nixosModules.raspberry-pi-5.bluetooth
  ];

  config = {
    modules = {
      base = {
        networkmanager.enable = true;
        raspberryPi = {
          enable = true;
        };
        ssh.openssh = {
          enable = true;
          byKeys = false;
        };
        users.${user.userName} = {
          enable = true;
          groups = [
            "networkmanager"
            "wheel"
          ];
          description = user.fullName;
        };
        version = "25.05";
      };
      software = {
        home-manager.enable = true;
      };
    };
  };
}
