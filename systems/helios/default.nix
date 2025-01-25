{
  imports = [
    ./hardware.nix
  ];

  olympus = {
    device = {
      cpu = "amd";
      gpu = "amd";
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
