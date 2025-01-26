{
  imports = [
    ./hardware.nix
    ./networking.nix
    ./overrides.nix
    ./services.nix
    ./users.nix
  ];

  olympus = {
    device = {
      cpu = "vm-amd";
      gpu = null;
    };
    system = {
      boot = {
        loader = "grub";
        loadRecommendedModules = true;
        enableKernelTweaks = true;
        initrd.enableTweaks = true;
        plymouth.enable = false;
      };
    };
  };
}
