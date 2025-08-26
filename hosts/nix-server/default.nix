{ user, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  config = {
    homelab = {
      enable = true;
      baseDomain = "homelab.local";
      services = {
        enable = true;
        audiobookshelf = {
          enable = true;
          host = "0.0.0.0";
        };
        homepage.enable = true;
        immich = {
          enable = true;
          host = "0.0.0.0";
        };
      };
    };
    modules = {
      base = {
        avahi.enable = true;
        bootLoader.enable = true;
        networkmanager.enable = true;
        ssh.openssh = {
          enable = true;
          byKeys = true;
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
