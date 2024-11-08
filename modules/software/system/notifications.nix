{ pkgs, ... }:

{
    environment.systemPackages = [
        pkgs.swaynotificationcenter
        pkgs.libnotify
    ];
}
