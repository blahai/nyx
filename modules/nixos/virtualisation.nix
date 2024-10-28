{ pkgs, lib, config, ... }:
{
  boot = {
    initrd.kernelModules = lib.mkBefore [ 
      "kvm-amd"
      "vfio_pci"
      "vfio_iommu_type1"
      "vfio"

      "amdgpu"
    ];
    kernelParams = [ 
      "amd_iommu=on"
      "amd_iommu=pt"
      "kvm.ignore_msrs=1"
      "vfio-pci.ids=1002:67df,1002:aaf0"
    ];
    extraModprobeConfig = ''
      softdep drm pre: vfio-pci
    '';
  };

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

    docker = {
      enable = true;
    };
  };

  users.users.pingu.extraGroups = [ "qemu-libvirtd" "libvirtd" "disk" "kvm" "docker" ];

  environment.systemPackages = with pkgs; [
    virt-manager
  ];


}
