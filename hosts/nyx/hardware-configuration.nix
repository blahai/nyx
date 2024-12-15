{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "nvme" "ahci" "xhci_pci" "usbhid" "hid_generic" "uas" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" "amd-pstate" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "zpool/root";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."/nix" = {
    device = "zpool/nix";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."/var" = {
    device = "zpool/var";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."/home" = {
    device = "zpool/home";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."/mnt/zootfs/Storage" = {
    device = "zootfs/Storage";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."/mnt/zootfs/Media" = {
    device = "zootfs/Media";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  # https://github.com/atuinsh/atuin/issues/952#issuecomment-1902164562
  fileSystems."/home/pingu/.local/share/atuin" = {
    device = "/dev/zvol/zpool/nixos/atuin";
    fsType = "ext4";
    options = [ "async" "auto" "nofail" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/BOOT";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  fileSystems."/mnt/ssd" = {
    device = "/dev/disk/by-uuid/e4c31e1c-6667-4582-8d6a-d142d6118ce2";
    fsType = "btrfs";
    options = [ "async" "auto" "noatime" "rw" ];
  };

  fileSystems."/mnt/ext" = {
    device = "/dev/disk/by-uuid/43280a82-cf9a-452e-9bdc-a8cc66ccd7c8";
    fsType = "btrfs";
    options = [ "async" "auto" "nofail" "noatime" ];
  };

  swapDevices = [{ device = "/dev/disk/by-uuid/04281bd7-784a-4287-b4f2-ce406d2ab6ac"; }];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = true;
}
