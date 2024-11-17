name: { lib, pkgs, pkgs-unstable, home-manager, inputs, version,
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
    inherit pkgs;

    specialArgs = {
      inherit pkgs-unstable;
      inherit inputs version;
      inherit hostname user;
      helper = import ./helper.nix;
    };

    modules = [
      ../hosts/${name}
      ../modules
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          users.${data.userName} = import ../modules/software/home/home.nix;

          useGlobalPkgs = true;
          useUserPackages = true;

          extraSpecialArgs = {
            inherit pkgs-unstable;
            inherit version;
            inherit hostname user;
          };
        };
      }
    ] ++ adtionalModules;
  }
