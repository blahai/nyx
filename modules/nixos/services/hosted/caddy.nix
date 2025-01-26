{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.services) mkServiceOption;

  cfg = config.olympus.services.caddy;
in {
  options.olympus.services.caddy = mkServiceOption "caddy" {domain = "blahai.gay";};

  config = mkIf cfg.enable {
    services.caddy = {
      enable = true;
    };
  };
}
