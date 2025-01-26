{
  lib,
  config,
  ...
}: let
  inherit (lib.trivial) id;
  inherit (lib.options) mkOption;
  inherit (lib.validators) anyHome;
  inherit (lib.strings) concatStringsSep;

  mkMetaOption = path:
    mkOption {
      default = anyHome config id path;
      example = true;
      description = "Does ${concatStringsSep "." path} meet the requirements";
      type = lib.types.bool;
    };
in {
  options.olympus.meta = {
    fish = mkMetaOption [
      "olympus"
      "programs"
      "fish"
      "enable"
    ];
    thunar = mkMetaOption [
      "olympus"
      "programs"
      "thunar"
      "enable"
    ];
    gui = mkMetaOption [
      "olympus"
      "programs"
      "gui"
      "enable"
    ];

    isWayland = mkMetaOption [
      "olympus"
      "meta"
      "isWayland"
    ];
    isWM = mkMetaOption [
      "olympus"
      "meta"
      "isWM"
    ];
  };
}
