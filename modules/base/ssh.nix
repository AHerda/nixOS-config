{ config, lib, ... }:

let
  cfg = config.modules.base.ssh;
  authorizedKeyFolder = name: /home/${name}/.ssh/authorizedKeys;
  authorizedKeyFile = name: file: /home/${name}/.ssh/authorizedKeys/${file};
  concatFunction = (name: value: {
    ${name}.openssh.authorizedKeys.keyFiles = with builtins;
      authorizedKeyFolder name |> readDir |> attrNames |> map (file: authorizedKeyFile name file);
  });
in {
  options.modules.base = {
    ssh.openssh = {
      enable = lib.mkEnableOption "Enable ssh server";
      byKeys = lib.mkEnableOption "Enable connecting only by keys";
    };
  };

  config = lib.mkMerge [
    {
      programs.ssh.startAgent = true;
    }
    (lib.mkIf cfg.openssh.enable {
      services.openssh.enable = true;
      users.users = lib.mkIf cfg.openssh.byKeys (lib.attrsets.filterAttrs (_: value: value.enable) cfg.users
        |> lib.attrsets.concatMapAttrs concatFunction);
    })
    # (lib.mkIf ( cfg.ssh.openssh.enable && cfg.ssh.openssh.byKeys ) {
    #   users.users = lib.attrsets.concatMapAttrs (concatFunction cfg.users);
    # })
  ];
}
