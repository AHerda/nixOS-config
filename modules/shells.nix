{ pkgs }:

let
  nixosShell = import ../lib/nixosShell.nix;
in {
  python = nixosShell "python" {
    inherit pkgs;
    packages = with pkgs; [
      (python313.withPackages(p: [
        p.matplotlib
        p.numpy
        p.pandas
        p.seaborn
      ]))
    ];
  };
  rust = nixosShell "rust" {
    inherit pkgs;
    packages = with pkgs; [
      rustup
      cargo
    ];
  };
  c = nixosShell "c" {
    inherit pkgs;
    packages = with pkgs; [
      clang
      clang-analyzer
      clang-tools
      cmake
      gcc
      gnumake
      libclang
      libgcc
    ];
  };
  x11docker = nixosShell "x11docker" {
    inherit pkgs;
    packages = with pkgs; [
      jq
      python313
      tini
      x11docker
      xorg.xorgserver
      xorg.xrandr
      xpra
    ];
  };
}
