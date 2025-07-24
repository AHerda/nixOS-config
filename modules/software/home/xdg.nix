{ osConfig, lib, ... }:

let
  cfgUsers = osConfig.modules.base.users;
in {
  options.modules.base.users.defaultApps = {
    enable = lib.mkEnableOption "default Applications";
  };
  # users = lib.attrsets.filterAttrs (_: value: value.enable) cfgUsers
  #   |> lib.attrsets.concatMapAttrs (name: _: {
  #     ${name} = {
  #
  #     };
  #   });
  config = lib.mkIf cfgUsers.defaultApps.enable {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        # "application/png" = "loupe";
        # "application/pdf" = "zen";
      };
    };
  };
}
