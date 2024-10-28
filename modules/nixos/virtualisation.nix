{ pkgs, lib, config, ... }:
let
  platform = "amd";
  vfioIds = [ "" "" ];
in {
  boot = {
    kernelModules = [ "kvm-${platform}" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
    kernelParams = [ "${platform}_iommu=on" "${platform}_iommu=pt" "kvm.ignore_msrs=1" ];
    extraModprobeConfig = "options vfio-pci ids=${builtins.concatStringsSep "," vfioIds}";
  };

  virtualisation = {
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
    };

    qemu = {
      package = pkgs.qemu_kvm;
      ovmf.enable = true;
    };

    docker = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    virt-manager
  ];


}
