{ lib, user, ... }:

{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ user.userName ];
  };

  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  nix.settings.auto-optimise-store = true;
}
