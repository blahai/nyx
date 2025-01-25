{
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption mkPackageOption;
  inherit (lib.attrsets) recursiveUpdate;

  mkProgram = pkgs: name: extraConfig:
    recursiveUpdate {
      enable = mkEnableOption "Enable ${name}";
      package = mkPackageOption pkgs name {};
    }
    extraConfig;
in {
  options.olympus.programs = {
    bash = mkProgram pkgs "bash" {
      enable.default = true;
      package.default = pkgs.bashInteractive;
    };

    zsh = mkProgram pkgs "zsh" {};

    fish = mkProgram pkgs "fish" {};
  };
}
