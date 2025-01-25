{lib, ...}: let
  inherit (lib.modules) mkForce mkAfter;
in {
  boot = {
    kernelParams = mkAfter [
      "noquiet"
      "toram"
    ];

    # have no need for systemd-boot
    loader.systemd-boot.enable = mkForce false;
    # we don't need to have any raid tools in our system
    swraid.enable = mkForce false;

    # https://github.com/NixOS/nixpkgs/issues/58959
    supportedFilesystems = mkForce [
      "btrfs"
      "ext4"
      "zfs"
      "vfat"
      "f2fs"
      "xfs"
    ];
  };
}
