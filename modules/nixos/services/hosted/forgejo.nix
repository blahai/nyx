{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf mkAfter;
  inherit (lib.services) mkServiceOption;
  inherit (lib.strings) removePrefix removeSuffix;
  inherit (lib.secrets) mkSecret;

  rdomain = config.networking.domain;
  cfg = config.olympus.services.forgejo;

  # stole this from https://github.com/isabelroses/dotfiles/blob/main/modules/nixos/services/selfhosted/forgejo.nix who
  # stole this from https://git.winston.sh/winston/deployment-flake/src/branch/main/config/services/gitea.nix who
  # stole it from https://github.com/getchoo
  theme = pkgs.fetchzip {
    url = "https://github.com/catppuccin/gitea/releases/download/v1.0.0/catppuccin-gitea.tar.gz";
    hash = "sha256-UsYJJ1j9erMih4OlFon604g1LvkZI/UiLgMgdvnyvyA=";
    stripRoot = false;
  };
in {
  options.olympus.services.forgejo = mkServiceOption "forgejo" {
    port = 3000;
    domain = "git.${rdomain}";
  };

  config = mkIf cfg.enable {
    age.secrets.forgejo-runner-token = mkSecret {
      file = "forgejo-runner-token";
      owner = "forgejo";
      group = "forgejo";
    };

    olympus.services = {
      caddy.enable = true;
    };

    systemd.services = {
      forgejo = {
        preStart = let
          inherit (config.services.forgejo) stateDir;
        in
          mkAfter ''
            rm -rf ${stateDir}/custom/public/assets
            mkdir -p ${stateDir}/custom/public/assets
            ln -sf ${theme} ${stateDir}/custom/public/assets/css
          '';
      };
    };

    users = {
      groups.git = {};

      users.git = {
        isSystemUser = true;
        createHome = false;
        group = "git";
      };
    };

    services = {
      forgejo = {
        package = pkgs.forgejo;
        enable = true;
        lfs.enable = true;
        settings = {
          DEFAULT.APP_NAME = "haigit";
          federation.ENABLED = true;
          service.DISABLE_REGISTRATION = true;
          actions = {
            ENABLED = true;
          };
          server = {
            ROOT_URL = "https://${cfg.domain}";
            DOMAIN = "${cfg.domain}";

            SSH_PORT = 22;
            SSH_LISTEN_PORT = 22;
            BUILTIN_SSH_SERVER_USER = "forgejo";
          };

          ui = {
            DEFAULT_THEME = "catppuccin-mocha-pink";
            THEMES = builtins.concatStringsSep "," (
              ["auto,forgejo-auto,forgejo-dark,forgejo-light,arc-gree,gitea"]
              ++ (map (name: removePrefix "theme-" (removeSuffix ".css" name)) (
                # IFD, https://github.com/catppuccin/nix/pull/179
                builtins.attrNames (builtins.readDir theme)
              ))
            );
          };

          "ui.meta" = {
            AUTHOR = "Elissa";
            DESCRIPTION = "My own selfhosted git place for random stuff :3";
          };

          session = {
            COOKIE_SECURE = true;
            # Sessions last for a month
            SESSION_LIFE_TIME = 86400 * 30;
          };
        };
      };

      gitea-actions-runner = {
        package = pkgs.forgejo-actions-runner;
        instances.default = {
          enable = true;
          name = "Theia";
          url = "https://${cfg.domain}";
          tokenFile = config.age.secrets.forgejo-runner-token.path;
          labels = [
            "ubuntu-latest:docker://node:22-bookworm"
            "nixos-latest:docker://nixos/nix"
            "lix-latest:docker://git.blahai.gay/blahai/lix"
          ];
        };
      };

      caddy.virtualHosts.${cfg.domain} = {
        extraConfig = ''
          reverse_proxy localhost:${toString cfg.port}
        '';
      };
    };
    # for forgejo runner
    virtualisation.docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };
}
