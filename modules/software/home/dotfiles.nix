{ config, lib, user, ... }:

let
  # toPath = path: /. + "${config.home.homeDirectory}/${path}";
  linkConfig = name: {
    ".config/${name}".source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/.dotfiles/.config/${name}";
  };
  linkHome = name: {
    "${name}".source = config.lib.file.mkOutOfStoreSymlink /. + "${config.home.homeDirectory}/.dotfiles/${name}";
  };
in
{
  home.file = lib.mkMerge [
    ( linkConfig "alacritty" )
    ( linkConfig "cava" )
    ( linkConfig "eww" )
    ( linkConfig "hypr" )
    ( linkConfig "ghostty" )
    ( linkConfig "kitty" )
    # ( linkConfig "nvim" )
    # ( linkConfig "nushell" )
    ( linkConfig "rofi" )
    ( linkConfig "oh-my-posh" )
    ( linkConfig "quickshell" )
    ( linkConfig "waybar" )
    ( linkConfig "starship" )

    ( linkHome "wallpapers" )
  ];
}
