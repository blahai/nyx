{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkDefault mkForce;
in {
  imports = [
    ./firewall

    ./ssh.nix
    ./tailscale.nix
  ];

  networking = {
    hostId = builtins.substring 0 8 (builtins.hashString "md5" config.networking.hostName);

    useDHCP = mkForce false;
    useNetworkd = mkForce true;

    usePredictableInterfaceNames = mkDefault true;

    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "9.9.9.9"
    ];

    enableIPv6 = true;
  };
}
