name: { lib, pkgs, pkgs-unstable, inputs,
  additionalModules ? [],
}:

let
  data = import ./data.nix {};
  hostname = name;
  user = {
    userName = data.userName;
    fullName = data.fullName;
    userEmail = data.userEmail;
  };
in
  lib.nixosSystem {
    inherit pkgs lib;

    specialArgs = {
      inherit inputs pkgs-unstable;
      inherit hostname user;
    };

    modules = [
      ../hosts/${name}
      ../modules
    ] ++ additionalModules;
  }
