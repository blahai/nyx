{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.attrsets) genAttrs;
  inherit (lib.options) mkEnableOption;
in {
  options.olympus.system.enableHjem =
    mkEnableOption "Should hjem be enabled"
    // {
      default = true;
    };

  config = mkIf config.olympus.system.enableHjem {
    hjem = {
      users = genAttrs config.olympus.system.users (name: ./${name});
      clobberByDefault = true;
      specialArgs = {inherit inputs;};
    };
  };
}
