{
  lib,
  pkgs,
  ...
}: {
  users.users.root = lib.modules.mkIf pkgs.stdenv.hostPlatform.isLinux {
    initialPassword = "changeme";

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILPbmiNqoyeKXk/VopFm2cFfEnV4cKCFBhbhyYB69Fuu"
    ];
  };
}
