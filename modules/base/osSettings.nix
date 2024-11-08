{ version, ... }:

{
  system.stateVersion = version;

  environment.variables = {
    EDITOR = "vim";
  };
}
