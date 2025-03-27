{pkgs, ...}: {
  services = {
    immich = {
      enable = true;
      host = "0.0.0.0";
      port = 2283;
      openFirewall = true;
      package = pkgs.immich;
      user = "immich";
      group = "immich";
      accelerationDevices = ["/dev/dri/renderD128"];
      mediaLocation = "/var/lib/immich";
    };
  };
}
