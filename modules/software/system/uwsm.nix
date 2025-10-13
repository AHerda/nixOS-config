{ config, lib, pkgs, ... }:

let
  cfg = config.modules.software.uwsm;
in
{
  options.modules.software.uwsm = {
    enable = lib.mkEnableOption "uwsm";
  };

  config = lib.mkIf cfg.enable {
    programs.uwsm = {
      enable = true;
      # waylandCompositors.niri = lib.mkIf config.modules.software.niri.enable {
      #   prettyName = "Niri";
      #   comment = "Niri compositor managed by UWSM";
      #   binPath = "${pkgs.niri}/bin/niri";
      # };
    };
  };
}
