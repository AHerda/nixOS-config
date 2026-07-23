{ pkgs, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  config = {
    homelab = {
      enable = true;
      baseDomain = "homelab.aherda.com";
      services = {
        enable = true;
        audiobookshelf = {
          enable = true;
          host = "0.0.0.0";
        };
        homepage = {
          enable = true;
          linkType = "by_urls";
        };
        immich = {
          enable = true;
          host = "0.0.0.0";
        };
        memos.enable = true;
        nextcloud.enable = true;
        owncloud.enable = true;
        vaultwarden.enable = true;
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
          shell = with pkgs; nushell;
        };
        tailscale.enable = true;
        version = "25.05";
      };
      software = {
        home-manager.enable = true;
        virtualisation = {
          enable = true;
          program = "podman";
        };
      };
    };
  };
}
