{ pkgs-unstable , ... }:

{
  programs.nushell = {
    enable = true;
    shellAliases = {
      l = "ls -al";
      ls = "ls";
      ll = "ls -l";
      cat = "bat";
      v = "nvim";
      ".." = "z ..";
      ssk = "kitten ssh";
      # update = "let path = (pwd); cd ~/nixos; sudo nix flake update; cd $path";
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos";
      rebuild-test = "sudo nixos-rebuild test --flake ~/nixos";
    };

    settings = {
      show_banner = false;
    };

    environmentVariables = {
      EDITOR = "nvim";
    };
    # plugins = with pkgs-unstable.nushellPlugins; [
    #   units
    #   formats
    #   highlight
    #   gstat
    #   query
    #   net
    # ];

    extraConfig = ''
      oh-my-posh init nu --config ~/.config/oh-my-posh/themes/my-theme.toml
    '';
  };
}
