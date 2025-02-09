{ config, lib, pkgs, ... }:

let
  cfg = config.modules.software.virtualisation;
in
{
  options.modules.software.virtualisation = {
    enable = lib.mkEnableOption "virtualisation";
    program = lib.mkOption {
      type = lib.types.enum [ "docker" "podman" "both" ];
      default = "docker";
      description = "Which virtualisation program to use";
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      (lib.mkIf (builtins.elem cfg.program [ "docker" "both" ]) {
        virtualisation.docker.enable = true;
        environment.systemPackages = [
          pkgs.lazydocker
        ];
      })
      (lib.mkIf (builtins.elem cfg.program [ "podman" "both" ]) {
        virtualisation.podman.enable = true;
      })
    ]
  );
}
