{
  config,
  lib,
  ...
}: let
  inherit (config.olympus) device;
  inherit (lib.modules) mkIf;
in {
  config = mkIf (device.cpu == "amd" || device.cpu == "vm-amd") {
    hardware.cpu.amd.updateMicrocode = true;

    boot.kernelModules = [
      "kvm-amd"
      "amd-pstate"
    ];
  };
}
