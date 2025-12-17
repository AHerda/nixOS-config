{ inputs, pkgs, lib, ... }:

{
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];
  config = {
    boot = {
      initrd.systemd.enable = true;
      loader.systemd-boot.enable = lib.mkForce false;
      bootspec.enableValidation = true;
      lanzaboote = {
        enable = true;
        pkiBundle = "/etc/secureboot";
      };
      initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/e55b8917-f9cc-4975-98a8-ff4bb4f0aaea";
    };
    environment.systemPackages = [
      pkgs.sbctl
    ];
  };
}
