{ config, lib, inputs, ... }:

let
  cfg = config.modules.base.raspberryPi;
in {
  options.modules.base.raspberryPi = {
    enable = lib.mkEnableOption "Enable raspberryPi 5 specific filesystem config";
  };

  config = lib.mkIf cfg.enable {
    fileSystems = {
      "/boot/firmware" = {
        device = "/dev/disk/by-uuid/2175-794E";
        fsType = "vfat";
        options = [
          "noatime"
          "noauto"
          "x-systemd.automount"
          "x-systemd.idle-timeout=1min"
        ];
      };
      "/" = {
        device = "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888";
        fsType = "ext4";
        options = [ "noatime" ];
      };
    };
  };
}
