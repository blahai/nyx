{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf mkDefault;
  inherit (lib.attrsets) optionalAttrs;
  inherit (lib.options) mkEnableOption mkPackageOption;

  cfg = config.olympus.system.boot;
in {
  config = mkIf (cfg.loader == "systemd-boot") {
    boot.loader.systemd-boot = {
      enable = mkDefault true;
      configurationLimit = 5;
      consoleMode = "max";
      editor = false;
    };
  };
}
