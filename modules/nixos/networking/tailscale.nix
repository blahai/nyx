{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf mkDefault;
  inherit (lib.options) mkEnableOption;
  inherit (config.services) tailscale;

  sys = config.olympus.system.networking;
  cfg = sys.tailscale;
in {
  options.olympus.system.networking.tailscale = {
    enable = mkEnableOption "Tailscale";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.tailscale];

    networking.firewall = {
      # always allow traffic from your Tailscale network
      trustedInterfaces = ["${tailscale.interfaceName}"];
      checkReversePath = "loose";
    };

    services.tailscale = {
      enable = true;
      openFirewall = true;
      useRoutingFeatures = mkDefault "server";
    };
  };
}
