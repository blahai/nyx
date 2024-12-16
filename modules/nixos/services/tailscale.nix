{ pkgs, ... }: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };
  environment.systemPackages = with pkgs; [
    trayscale
  ];
}
