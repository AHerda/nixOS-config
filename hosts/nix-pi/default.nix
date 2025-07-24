{ inputs, user, ... }:

{
  imports = [
    inputs.raspberry-pi-nix.nixosModules.raspberry-pi
    inputs.raspberry-pi-nix.nixosModules.sd-image
  ];

  config = {
    raspberry-pi-nix.board = "bcm2712";
    modules = {
      base = {
        # raspberryPi = {
        #   enable = true;
        #   board = "bcm2712";
        # };
        ssh.openssh = {
          enable = true;
          byKeys = false;
        };
        users.${user.userName} = {
          enable = true;
          groups = [
            "audio"
            "docker"
            "media"
            "networkmanager"
            "surface-control"
            "video"
            "wheel"
          ];
          description = user.fullName;
        };
        version = "25.05";
      };
    };
  };
}
