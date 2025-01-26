{
  lib,
  pkgs,
  ...
}: let
  inherit (lib.programs) mkProgram;
in {
  options.olympus.programs = {
    bash = mkProgram pkgs "bash" {
      enable.default = true;
      package.default = pkgs.bashInteractive;
    };

    fish = mkProgram pkgs "fish" {};
  };
}
