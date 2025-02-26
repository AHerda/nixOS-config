{ config, lib, pkgs, pkgs-unstable, ... }:

let
    cfg = config.modules.software.office;
in
{
    options.modules.software.office = {
        enable = lib.mkEnableOption "office";
    };

    config = lib.mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            pkgs-unstable.libreoffice
        ];
    };
}
