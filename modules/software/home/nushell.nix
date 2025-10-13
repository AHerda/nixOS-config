{ pkgs, ... }:

{
  programs.nushell = {
    enable = true;
    package = pkgs.nushell;
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
      completions = {
        case_sensitive = false;
        quick = true;
        partial = true;
        algorithm = "fuzzy";
        external.enable = true;
        external.max_results = 100;
      };
    };

    environmentVariables = {
      EDITOR = "nvim";
    };
    plugins = with pkgs.nushellPlugins; [
      formats
      gstat
      highlight
      # net
      query
      # units
    ];

    loginFile.text = ''
      try {
          uwsm check may-start
          uwsm select
          uwsm start default
      }
    '';

    extraConfig = ''
      let carapace_completer = {|spans|
        carapace $spans.0 nushell ...$spans | from json
      }
      $env.config.completions.external.completer = $carapace_completer

      oh-my-posh init nu --config ~/.config/oh-my-posh/themes/my-theme.toml

      def imssync [destination_dir, server, ...args] {
          print $"($destination_dir)"
          print $"($server)"
          print $"($args)"
          nu -c $"rsync -avz --progress --filter='-,p .git/' --filter='-,p .svn/' --exclude='ccache' --exclude='bts_env' --exclude='bm/*/bin' --exclude='tools/im_generator/bin' ./ ($server):/var/fpwork/herda/($destination_dir)" # ($...args)"
      }

      def --env proxy [] {
          $env.HTTP_PROXY = "http://10.158.100.2:8000"
          $env.HTTPS_PROXY = "http://10.158.100.2:8000"

          $env.http_proxy = "http://10.158.100.2:8000"
          $env.https_proxy = "http://10.158.100.2:8000"

          echo "Proxy on!"
      }

      def --env unproxy [] {
          hide-env http_proxy https_proxy ftp_proxy
      }

      def --env agentStart [] {
          ssh-agent -c
              | lines
              | first 2
              | parse "setenv {name} {value};"
              | transpose -r
              | into record
              | load-env
      }
    '';
  };
}
