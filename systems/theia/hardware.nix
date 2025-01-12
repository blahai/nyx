{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/09e65ff9-2195-41d8-b6a4-671c306742c3";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/FED3-A372";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };
  };
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];
}
