{ config, lib, ... }:

let
  urlType = lib.types.strMatching "^https?://.*(:[0-9]+)?$";
  cfg = config.modules.base.proxy;
in
{
  options.modules.base.proxy = {
    enable = lib.mkEnableOption "proxy";
    url = lib.mkOption {
      type = urlType;
      description = "The proxy URL to use for network connections.";
    };
    noProxyUrls = lib.mkOption {
      type = lib.types.commas;
      description = "The URLs to not use proxy for.";
    };
  };

  config = lib.mkIf cfg.enable {
    networking.proxy.httpProxy = cfg.url;
    networking.proxy.httpsProxy = cfg.url;
    networking.proxy.ftpProxy = cfg.url;
    networking.proxy.noProxy = cfg.noProxyUrls;
  };
}
