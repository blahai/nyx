{
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) enum listOf str;
in {
  options.olympus.system = {
    mainUser = mkOption {
      type = enum config.olympus.system.users;
      description = "The username of the main user for your system";
      default = builtins.elemAt config.olympus.system.users 0;
    };

    users = mkOption {
      type = listOf str;
      default = ["pingu"];
      description = ''
        A list of users that you wish to declare as your non-system users. The first username
        in the list will be treated as your main user unless {option}`olympus.system.mainUser` is set.
      '';
    };
  };
}
