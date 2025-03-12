{ config, lib, user, ... }:

let
  toPath = path: /. + "${config.home.homeDirectory}/${path}";
in
{
  home.file = {
    ".config/alacritty".source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/.dotfiles/.config/alacritty";
    ".config/cava".source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/.dotfiles/.config/cava";
    ".config/eww".source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/.dotfiles/.config/eww";
    ".config/hypr".source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/.dotfiles/.config/hypr";
    ".config/ghostty".source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/.dotfiles/.config/ghostty";
    ".config/kitty".source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/.dotfiles/.config/kitty";
    # ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/.dotfiles/.config/nvim";
    ".config/nushell".source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/.dotfiles/.config/nushell";
    ".config/rofi".source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/.dotfiles/.config/rofi";
    ".config/oh-my-posh".source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/.dotfiles/.config/oh-my-posh";
    ".config/waybar".source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/.dotfiles/.config/waybar";

    "wallpapers".source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/.dotfiles/wallpapers";
  };
}
