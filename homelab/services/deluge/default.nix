{ config, lib, ... }:

let
  cfg = config.homelab.services.deluge;
in {
  options.homelab.services.deluge = {
    enable = lib.mkEnableOption "Deluge torrent client";
    configDir = lib.mkOption {};
  };
}
