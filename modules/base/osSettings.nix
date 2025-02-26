{ version, ... }:

{
  system.stateVersion = version;

  environment.variables = {
    EDITOR = "vim";
    NIXOS_OZONE_WL=1;
  };
}
