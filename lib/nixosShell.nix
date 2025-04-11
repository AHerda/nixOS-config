name: { pkgs,
  packages ? [],
  shellHook ? ''
    echo "Entering ${name} dev shell"
    nu
  '',
  ...
}:

pkgs.mkShell {
  inherit packages name shellHook;
}
