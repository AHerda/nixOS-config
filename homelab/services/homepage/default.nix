{ config, lib, hostname, ... }:

let
  cfg = config.homelab.services.homepage;
  services = config.homelab.services;
  homelab = config.homelab;
in {
  options.homelab.services.homepage = {
    enable = lib.mkEnableOption "Enable HomePage dashboard";
    linkType = lib.mkOption {
      type = lib.types.enum ["by_urls" "by_hostname"];
      default = "by_hostname";
      description = ''
        How to evaluate links to services on homepage.
        Possible: "by_urls" / "by_hostname"
      '';
    };
    misc = lib.mkOption {
      default = [ ];
      type = lib.types.listOf (
        lib.types.attrsOf (
          lib.types.submodule {
            options = {
              description = lib.mkOption {
                type = lib.types.str;
              };
              href = lib.mkOption {
                type = lib.types.str;
              };
              siteMonitor = lib.mkOption {
                type = lib.types.str;
              };
              icon = lib.mkOption {
                type = lib.types.str;
              };
            };
          }
        )
      );
    };
  };

  config = lib.mkIf cfg.enable {
    services.glances.enable = true;
    services.homepage-dashboard = {
      enable = true;
      openFirewall = true;
      # environmentFile = builtins.toFile "homepage.env" "HOMEPAGE_ALLOWED_HOSTS=${homelab.baseDomain}";
      allowedHosts = "nix-server.local:8082,${homelab.baseDomain}";
      customCSS = ''
        body, html {
          font-family: SF Pro Display, Helvetica, Arial, sans-serif !important;
        }
        .font-medium {
          font-weight: 700 !important;
        }
        .font-light {
          font-weight: 500 !important;
        }
        .font-thin {
          font-weight: 400 !important;
        }
        #information-widgets {
          padding-left: 1.5rem;
          padding-right: 1.5rem;
        }
        div#footer {
          display: none;
        }
        .services-group.basis-full.flex-1.px-1.-my-1 {
          padding-bottom: 3rem;
        };
      '';
      settings = {
        title = "AHerda's HomeLab";
        theme = "dark";
        color = "neutral";
        favicon = "https://img.icons8.com/?size=100&id=4NkrBMaFGmWr&format=png&color=000000";
        layout = [
          {
            Glances = {
              header = false;
              style = "row";
              columns = 3;
            };
          }
          {
            Arr = {
              header = true;
              style = "column";
            };
          }
          {
            Downloads = {
              header = true;
              style = "column";
            };
          }
          {
            Media = {
              header = true;
              style = "column";
            };
          }
          {
            Services = {
              header = true;
              style = "column";
            };
          }
        ];
        headerStyle = "clean";
        statusStyle = "dot";
        hideVersion = "false";
      };
      services =
        let
          port = toString config.services.glances.port;
          homepageCategories = [
            "Arr"
            "Media"
            "Downloads"
            "Services"
          ];
          categoryServices = category: (lib.attrsets.filterAttrs (name: value: value ? homepage && value.homepage.category == category) homelab.services);
          nameOfCategoryServices = category: (lib.attrsets.mapAttrsToList (name: value: name) (categoryServices "${category}"));
          serviceConfig = service: {
            "${services.${service}.homepage.name}" = lib.mkMerge [
              {
                icon = services.${service}.homepage.icon;
                description = services.${service}.homepage.description;
              }
              (lib.mkIf (cfg.linkType == "by_hostname") {
                href = "http://${hostname}:${toString services.${service}.port}";
                siteMonitor = "http://${hostname}:${toString services.${service}.port}";
              })
              (lib.mkIf (cfg.linkType == "by_urls") {
                href = "http://${services.${service}.url}";
                siteMonitor = "http://${services.${service}.url}";
              })
            ];
          };
          categoryConfig = category: {
            "${category}" = lib.lists.forEach (nameOfCategoryServices category) serviceConfig;
          };
        in builtins.concatLists [
          (lib.lists.forEach homepageCategories categoryConfig)
          [ { Misc = cfg.misc; } ]
          [
            {
              Glances = [
                {
                  Info = {
                    widget = {
                      type = "glances";
                      url = "http://localhost:${port}";
                      metric = "info";
                      chart = false;
                      version = 4;
                    };
                  };
                }
                {
                  Memory = {
                    widget = {
                      type = "glances";
                      url = "http://localhost:${port}";
                      metric = "memory";
                      chart = false;
                      version = 4;
                    };
                  };
                }
                {
                  Processes = {
                    widget = {
                      type = "glances";
                      url = "http://localhost:${port}";
                      metric = "process";
                      chart = false;
                      version = 4;
                    };
                  };
                }
                {
                  "CPU Usage" = {
                    widget = {
                      type = "glances";
                      url = "http://localhost:${port}";
                      metric = "cpu";
                      chart = true;
                      version = 4;
                    };
                  };
                }
                {
                  "CPU Temp" = {
                    widget = {
                      type = "glances";
                      url = "http://localhost:${port}";
                      metric = "sensor:Package id 0";
                      chart = true;
                      version = 4;
                    };
                  };
                }
                {
                  Network = {
                    widget = {
                      type = "glances";
                      url = "http://localhost:${port}";
                      metric = "network:wlp2s0";
                      chart = true;
                      version = 4;
                    };
                  };
                }
              ];
            }
          ]
        ];
    };
    services.caddy.virtualHosts.${homelab.baseDomain} = {
      extraConfig = "reverse_proxy http://nix-server.local:${toString config.services.homepage-dashboard.listenPort}";
    };
  };
}
