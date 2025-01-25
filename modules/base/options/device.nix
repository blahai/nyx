{lib, ...}: let
  inherit (lib.types) enum;
  inherit (lib.options) mkOption;
in {
  options.olympus.device.type = mkOption {
    type = enum [
      "laptop"
      "desktop"
      "server"
      "hybrid"
      "vm"
    ];
    default = "";
  };
}
