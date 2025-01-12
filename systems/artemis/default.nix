{
  imports = [
    ./hardware.nix
  ];

  olympus = {
    device = {
      cpu = "amd";
      gpu = "nvidia";
    };
    system = {
      boot = {
        loader = "systemd-boot";
        loadRecommendedModules = true;
        enableKernelTweaks = true;
        initrd.enableTweaks = true;
        plymouth.enable = false;
      };
    };
  };
}
