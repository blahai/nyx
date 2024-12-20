{pkgs, ...}: {
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    dataDir = "/mnt/zootfs/Media/jellyfin";
  };
}
