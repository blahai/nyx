{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf mkDefault;
  inherit (lib.options) mkOption;
  inherit (lib.types) nullOr str;
  cfg = config.olympus.system.boot;
in {
  options.olympus.system.boot.grub = {
    device = mkOption {
      type = nullOr str;
      default = "nodev";
      description = "The device to install the bootloader to.";
    };
  };

  config = mkIf (cfg.loader == "grub") {
    boot.loader.grub = {
      enable = mkDefault true;
      useOSProber = false;
      efiSupport = false;
      enableCryptodisk = mkDefault false;
      inherit (cfg.grub) device;
      theme = null;
      backgroundColor = null;
      splashImage = null;
    };
  };
}
