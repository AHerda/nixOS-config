{ pkgs, pkgs-unstable, ... }:

{
    services.printing = {
        enable = true;
        drivers = with pkgs; [
            hplip
        ];
    };

    hardware.printers = {
        ensurePrinters = [ ];
        ensureDefaultPrinter = "HP_3700";
    };
}
