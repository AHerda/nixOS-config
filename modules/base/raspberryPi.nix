{ config, lib, inputs, ... }:

let
  cfg = config.modules.base.raspberryPi;
in {
  options.modules.base.raspberryPi = {
    enable = lib.mkEnableOption "raspberryPi";
    board = lib.mkOption {
      type = lib.types.str;
      description = "Board type used in host model";
    };
  };

  imports = [
    inputs.raspberry-pi-nix.nixosModules.raspberry-pi
    inputs.raspberry-pi-nix.nixosModules.sd-image
  ];

  config = lib.mkIf cfg.enable {
    raspberry-pi-nix.board = cfg.board;
  };
}
