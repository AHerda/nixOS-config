name: { nixpkgs, home-manager, inputs, system, version,
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
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit system;
  };
in 
  nixpkgs.lib.nixosSystem {
    inherit system;

    specialArgs = {
      inherit inputs version pkgs-unstable;
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
            inherit pkgs-unstable version;
            inherit hostname user;
          };
        };
      }
    ] ++ adtionalModules;
  }
