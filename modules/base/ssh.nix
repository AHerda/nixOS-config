{ config, lib, ... }:

let
  cfg = config.modules.base;
  authorizedKeyFolder = name: /home/${name}/.ssh/authorizedKeys;
  authorizedKeyFile = name: file: /home/${name}/.ssh/authorizedKeys/${file};
  concatFunction = (name: _: {
    openssh.authorizedKeys.keyFiles = with builtins;
      authorizedKeyFolder name |> readDir |> attrNames |> map (file: authorizedKeyFile name file);
  });
in {
  options.modules.base = {
    ssh.openssh = {
      enable = lib.mkEnableOption "Enable ssh server";
      byKeys = lib.mkEnableOption "Enable connecting only by keys";
    };
    ssh.startAgent = lib.mkEnableOption "Start ssh-agent on machine start (not working for nushell)";
  };

  config = lib.mkMerge [
    {
      programs.ssh.startAgent = cfg.ssh.startAgent;
    }
    (lib.mkIf cfg.ssh.openssh.enable {
      services.openssh.enable = true;
    })
    (lib.mkIf ( cfg.ssh.openssh.enable && cfg.ssh.openssh.byKeys ) {
      services.openssh.settings.PasswordAuthentication = false;
      users.users = (lib.attrsets.filterAttrs (_: value: value.enable) cfg.users
        |> builtins.mapAttrs concatFunction);
    })
  ];
}
