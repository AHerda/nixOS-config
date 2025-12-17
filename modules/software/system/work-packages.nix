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
            openconnect
            # globalprotect-openconnect
            meld
            openssl
            gtk2
            gtk2-x11

            microsoft-identity-broker
            microsoft-edge
            seahorse
        ];
        services.intune.enable = true;

        nixpkgs.overlays = [
            (final: prev: {
                microsoft-identity-broker = prev.microsoft-identity-broker.overrideAttrs (previousAttrs: {
                    src = pkgs.fetchurl {
                        url = "https://packages.microsoft.com/ubuntu/22.04/prod/pool/main/m/microsoft-identity-broker/microsoft-identity-broker_2.0.1_amd64.deb";
                        hash = "sha256-v/FxtdvRaUHYqvFSkJIZyicIdcyxQ8lPpY5rb9smnqA=";
                    };
                });
            })
        ];
    };
}
