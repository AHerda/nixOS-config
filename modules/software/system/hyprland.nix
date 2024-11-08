{ pkgs, ... }:

{
  # configure hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    hyprlock
    hypridle
    hyprpaper
    waybar
  ];
}
