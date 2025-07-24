{ pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    # languages / compilers
    eww
    julia
    pkgs-unstable.quickshell

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
