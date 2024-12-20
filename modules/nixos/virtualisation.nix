{
  pkgs,
  lib,
  config,
  ...
}: let
  enableIOMMU = true;
in {
  boot = lib.mkIf enableIOMMU {
    initrd.kernelModules = lib.mkBefore [
      "kvm-amd"
      "vfio_pci"
      "vfio_iommu_type1"
      "vfio"
    ];
    kernelParams = [
      "amd_iommu=on"
      "amd_iommu=pt"
      "kvm.ignore_msrs=1"
      "vfio-pci.ids=1002:67df,1002:aaf0"
    ];
    extraModprobeConfig = ''
      softdep drm pre: vfio-pci
      options kvm_amd nested=1
      options kvm ignore_msrs=1 report_ignored_msrs=0
    '';
  };

  hardware.ksm.enable = true;

  virtualisation = {
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";

      qemu = {
        package = pkgs.qemu_kvm;
        ovmf.enable = true;
      };
    };

    docker = {enable = true;};
  };

  programs = {virt-manager = {enable = true;};};

  users.users.pingu.extraGroups = ["qemu-libvirtd" "libvirtd" "disk" "kvm" "docker"];

  environment.systemPackages = with pkgs; [
    python3 # scripts, cba to use nix shell all the time
    usbutils
    pciutils
    virt-manager
    moonlight-qt # for linux vms
    looking-glass-client # for windows vms :husk:
  ];
}
