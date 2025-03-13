{ pkgs, pkgs-unstable, ... }:

{
  programs.nix-ld.enable = true;
  environment.systemPackages = with pkgs; [
    # languages / compilers
    eww
    julia
    pkgs-unstable.quickshell
    wiremix
    impala

    # uni apps
    # pkgs-unstable.wolfram-engine
    # pkgs-unstable.mathematica
    subversion
    glpk

    # other development sofware
    (gnuradio.override {
      extraPackages = with gnuradioPackages; [
        osmosdr
      ];
      extraPythonPackages = with gnuradio.python.pkgs; [
        numpy
      ];
    })
  ];
}
