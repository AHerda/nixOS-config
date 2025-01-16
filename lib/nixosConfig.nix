name: { lib, pkgs, pkgs-unstable, inputs, version,
  adtionalModules ? [],
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
      inherit pkgs-unstable;
      inherit inputs version;
      inherit hostname user;
    };

    modules = [
      ../hosts/${name}
      ../modules
    ] ++ adtionalModules;
  }
