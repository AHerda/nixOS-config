{ config, lib, ... }:

let
  cfg = config.modules.base.security;
in {
  options.modules.base.security= {
    sudo = lib.mkEnableOption "sudo";
    doas = lib.mkEnableOption "doas";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.sudo {
      security.sudo.enable = true;
    })
    (lib.mkIf cfg.doas {
      security.doas = {
        enable = true;
        extraRules = [{
          groups = [ "wheel" ];
          keepEnv = true;
          persist = true;
        }];
      };
    })
  ];
}
