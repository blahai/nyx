{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (config.olympus) device;
in {
  config = mkIf (device.gpu == "amd") {
    services.xserver.videoDrivers = ["amdgpu"];

    boot = {
      kernelModules = ["amdgpu"];
      initrd.kernelModules = ["amdgpu"];
    };

    # enables AMDVLK & OpenCL support
    hardware.graphics.extraPackages = [
      pkgs.rocmPackages.clr
      pkgs.rocmPackages.clr.icd
    ];
  };
}
