{ config, lib, user, ... }:

{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = []
      ++ lib.optionals (config.modules.base.users.${user.userName}.enable) [ user.userName ];
  };

  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "18:10";
    options = lib.mkDefault "--delete-older-than 1d";
  };

  # only for big storage, take a lot of storage to use that
  nix.settings.auto-optimise-store = true;
}
