{
  lib,
  config,
  ...
}: let
  inherit (builtins) elem;
  inherit (lib.modules) mkIf;
in {
  config = mkIf (elem "pingu" config.olympus.system.users) {
    users.users.pingu.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILPbmiNqoyeKXk/VopFm2cFfEnV4cKCFBhbhyYB69Fuu"
    ];
  };
}
