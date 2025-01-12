{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (config.olympus) device;
  inherit (lib.modules) mkIf mkMerge mkDefault;

  isHybrid = device.gpu == "hybrid-nv";
in {
  config = mkIf (device.gpu == "nvidia" || device.gpu == "hybrid-nv") {
    # nvidia drivers kinda are unfree software
    nixpkgs.config.allowUnfree = true;

    services.xserver = mkMerge [
      {videoDrivers = ["nvidia"];}
    ];

    boot = {
      # blacklist nouveau module as otherwise it conflicts with nvidia drm
      blacklistedKernelModules = ["nouveau"];

      # Enables the Nvidia's experimental framebuffer device
      # fix for the imaginary monitor that does not exist
      kernelParams = ["nvidia_drm.fbdev=1"];
    };

    environment = {
      sessionVariables = mkMerge [
        {
          LIBVA_DRIVER_NAME = "nvidia";
          WLR_DRM_DEVICES = mkDefault "/dev/dri/card1";
        }
      ];

      systemPackages = builtins.attrValues {
        inherit (pkgs.nvtopPackages) nvidia;

        inherit
          (pkgs)
          # mesa
          mesa
          # vulkan
          vulkan-tools
          vulkan-loader
          vulkan-validation-layers
          vulkan-extension-layer
          # libva
          libva
          libva-utils
          ;
      };
    };

    hardware = {
      nvidia = {
        package = mkDefault config.boot.kernelPackages.nvidiaPackages.beta;

        prime.offload = {
          enable = isHybrid;
          enableOffloadCmd = isHybrid;
        };

        powerManagement = {
          enable = mkDefault true;
          finegrained = mkDefault false;
        };

        open = false; # dont use the open drivers by default
        nvidiaSettings = false; # adds nvidia-settings to pkgs, so useless on nixos
        nvidiaPersistenced = true;
        # forceFullCompositionPipeline = true;
      };

      graphics = {
        extraPackages = [pkgs.nvidia-vaapi-driver];
        extraPackages32 = [pkgs.pkgsi686Linux.nvidia-vaapi-driver];
      };
    };
  };
}
