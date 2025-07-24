{ config, lib, pkgs, ... }:

let
  cfg = config.modules.base.users;
  userOpts = _: {
    options = {
      enable = lib.mkEnableOption "If set to false the user will not be created";
      description = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "Description of user";
      };
      groups = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "List of user additional groups";
      };
    };
  };
in {
  options.modules.base.users = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule userOpts);
    default = {};
    description = "Users to create";
  };

  config = lib.mkMerge [
    {
      users.defaultUserShell = pkgs.bash;
      users.users.root.initialPassword = "root";
    }
    {
      users.users = lib.attrsets.filterAttrs (_: value: value.enable) cfg
        |> lib.attrsets.concatMapAttrs (name: value: {
          ${name} = {
            isNormalUser = true;
            description = value.description;
            extraGroups = value.groups;
            shell = pkgs.zsh;
            initialPassword = "${name}";
          };
        });
    }
  ];
}
