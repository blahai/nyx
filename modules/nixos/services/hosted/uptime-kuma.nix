{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.services) mkServiceOption;

  rdomain = config.networking.domain;
  cfg = config.olympus.services.uptime-kuma;
in {
  options.olympus.services.uptime-kuma = mkServiceOption "uptime-kuma" {
    port = 3001;
    domain = "kuma.${rdomain}";
  };

  config = mkIf cfg.enable {
    services.uptime-kuma = {
      enable = true;

      # https://github.com/louislam/uptime-kuma/wiki/Environment-Variables
      settings.PORT = toString cfg.port;
    };

    services.caddy.virtualHosts.${cfg.domain} = {
      extraConfig = ''
        reverse_proxy localhost:${cfg.port}
      '';
    };
  };
}
