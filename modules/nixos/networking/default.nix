{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkDefault mkForce;
in {
  imports = [
  ];

  networking = {
    hostId = builtins.substring 0 8 (builtins.hashString "md5" config.networking.hostName);

    useDHCP = mkForce false;
    useNetworkd = mkForce true;

    usePredictableInterfaceNames = mkDefault true;
  };
}
