{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkForce;
in {
  imports = [
    ./fail2ban.nix
  ];

  config = {
    networking.firewall = {
      enable = true;
      package = pkgs.iptables;

      allowedTCPPorts = [
        443
        80
      ];
      allowedUDPPorts = [];

      # make a much smaller and easier to read log
      logReversePathDrops = true;
      logRefusedConnections = false;

      checkReversePath = mkForce false;
    };
  };
}
