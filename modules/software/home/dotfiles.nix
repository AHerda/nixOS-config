{ config, lib, user, ... }:

let
  # homeDir = "/home/${user.userName}";
  # nixosDir = "../../../..";
  # toPathRelative = path: ./. + "${nixosDir}/${path}";
  toPath = path: /. + "${config.home.homeDirectory}/${path}";
in
{
  # xdg.configFile.".config".source = toPath ".dotfiles/.config";
  home.file = {
    # ".zshrc".source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/.dotfiles/.zshrc";
    # ".config".source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/.dotfiles/.config";
    ".config/alacritty".source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/.dotfiles/.config/alacritty";
    ".config/eww".source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/.dotfiles/.config/eww";
    ".config/hypr".source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/.dotfiles/.config/hypr";
    ".config/kitty".source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/.dotfiles/.config/kitty";
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/.dotfiles/.config/nvim";
    ".config/nushell".source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/.dotfiles/.config/nushell";
    ".config/oh-my-posh".source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/.dotfiles/.config/oh-my-posh";
    ".config/waybar".source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/.dotfiles/.config/waybar";
  };
  
  # xdg.configFile.".zshrc".source = toPath ".dotfiles/.zshrc";
  # xdg.configFile.".zshrc".source = config.lib.file.mkOutOfStoreSymlink ./. + "${config.home.homeDirectory}/.dotfiles/.zshrc";
  # xdg.configFile.".config/alacritty".source = toPath ".dotfiles/.config/alacritty";
  # xdg.configFile.".config/hypr".source = toPath ".dotfiles/.config/hypr";
  # xdg.configFile.".config/kitty".source = toPath ".dotfiles/.config/kitty";
  # xdg.configFile.".config/nvim".source = toPath ".dotfiles/.config/nvim";
  # xdg.configFile.".config/oh-my-posh".source = toPath ".dotfiles/.config/oh-my-posh";
  # xdg.configFile.".config/waybar".source = toPath ".dotfiles/.config/waybar";
}
