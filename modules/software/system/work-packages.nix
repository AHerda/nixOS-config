{ config, lib, pkgs, pkgs-unstable, ... }:

let
    cfg = config.modules.software.workPackages;
in
{
    options.modules.software.workPackages = {
        enable = lib.mkEnableOption "workPackages";
    };

    config = lib.mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            pkgs-unstable.intune-portal
            openconnect
            globalprotect-openconnect
            meld
            openssl
        ];
    };
}
