{ pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    # languages / compilers
    cmake
    eww
    gcc
    gnumake
    julia
    python313
    rustup

    # uni apps
    # pkgs-unstable.wolfram-engine
    # pkgs-unstable.mathematica
    subversion

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
