{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.services) mkServiceOption;
  inherit (lib.secrets) mkSecret;

  rdomain = config.networking.domain;
  cfg = config.olympus.services.vaultwarden;
in {
  options.olympus.services.vaultwarden = mkServiceOption "vaultwarden" {
    port = 8222;
    domain = "vault.${rdomain}";
  };

  config = mkIf cfg.enable {
    age.secrets.vaultwarden-env = mkSecret {
      file = "vaultwarden-env";
      owner = "vaultwarden";
      group = "vaultwarden";
    };

    services = {
      vaultwarden = {
        enable = true;
        environmentFile = config.age.secrets.vaultwarden-env.path;

        config = {
          DOMAIN = "https://${cfg.domain}";
          ROCKET_ADDRESS = cfg.host;
          ROCKET_PORT = cfg.port;
          extendedLogging = true;
          invitationsAllowed = true;
          useSyslog = true;
          logLevel = "warn";
          showPasswordHint = false;
          SIGNUPS_ALLOWED = false;
          signupsAllowed = false;
          signupsDomainsWhitelist = "${rdomain}";
          dataDir = "/var/lib/vaultwarden";
        };
      };

      caddy.virtualHosts.${cfg.domain} = {
        extraConfig = ''
          reverse_proxy localhost:${toString cfg.port}
        '';
      };
    };
  };
}
