{ config, lib, ... }:

let
  cfg = config.software.ai;
  cfg = config.modules.software.ai;
in
{
  options.modules.software.ai = {
    enable = lib.mkEnableOption "ai";
  };

  config = lib.mkIf cfg.enable {
    services.ollama.enable = true;
  };
}
