{
  lib,
  pkgs,
  config,
  modulesPath,
  ...
}: let
  inherit (lib.modules) mkForce mkIf;
in {
  imports = [(modulesPath + "/profiles/qemu-guest.nix")];

  config = {
    services = {
      smartd.enable = mkForce false; # Unavailable - device lacks SMART capability.
      qemuGuest.enable = true;

      networkd-dispatcher = mkIf config.olympus.system.networking.tailscale.enable {
        enable = true;
        rules."50-tailscale" = {
          onState = ["routable"];
          script = ''
            ${
              lib.getExe pkgs.ethtool
            } -K ens3 rx-udp-gro-forwarding on rx-gro-list off
          '';
        };
      };
    };
    systemd.services.qemu-guest-agent.path = [pkgs.shadow];

    system.stateVersion = mkForce "25.05";

    boot = {
      kernelParams = ["net.ifnames=0"];
      kernel.sysctl = {
        "net.ipv4.ip_forward" = true;
        "net.ipv6.conf.all.forwarding" = true;
      };

      initrd = {
        availableKernelModules = [
          "ata_piix"
          "uhci_hcd"
          "virtio_pci"
          "virtio_scsi"
          "ahci"
          "sr_mod"
          "virtio_blk"
        ];
        kernelModules = ["dm-snapshot"];
      };

      loader.grub = {
        enable = true;
        useOSProber = mkForce false;
        efiSupport = mkForce false;
        enableCryptodisk = false;
        theme = mkForce null;
        backgroundColor = mkForce null;
        splashImage = mkForce null;
        device = mkForce "/dev/vda";
      };
    };
  };
}
