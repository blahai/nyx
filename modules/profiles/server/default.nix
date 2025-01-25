{lib, ...}: let
  inherit (lib.modules) mkForce;
in {
  time.timeZone = mkForce "UTC";

  olympus.device.type = "server";
}
