{lib, ...}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) enum;
in {
  imports = [
    ./systemd-boot.nix
    ./grub.nix
  ];

  options.olympus.system.boot.loader = mkOption {
    type = enum [
      "none"
      "grub"
      "systemd-boot"
    ];
    default = "none";
    description = "The bootloader";
  };
}
