{
  imports = [
    ./hardware.nix
  ];

  olympus = {
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
