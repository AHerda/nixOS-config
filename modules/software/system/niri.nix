{ config, lib, pkgs, ... }:

let
    cfg = config.modules.software.niri;
in
{
    options.modules.software.niri = {
        enable = lib.mkEnableOption "niri";
    };

    config = lib.mkIf cfg.enable {
        programs.niri.enable = true;
        environment.systemPackages = [
          pkgs.xwayland-satellite
        ];
    };
}
