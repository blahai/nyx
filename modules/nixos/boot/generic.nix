{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf mkForce mkMerge mkDefault mkOverride;
  inherit (lib.lists) optionals;
  inherit (lib.options) mkOption mkEnableOption literalExpression;
  inherit (lib.types) str raw listOf package;

  cfg = config.olympus.system.boot;
in {
  options.olympus.system.boot = {
    enableKernelTweaks = mkEnableOption "security and performance related kernel parameters";
    recommendedLoaderConfig = mkEnableOption "tweaks for common bootloader configs per my liking";
    loadRecommendedModules = mkEnableOption "kernel modules that accommodate for most use cases";

    kernel = mkOption {
      type = raw;
      default = pkgs.linuxPackages_6_12;
      description = "The kernel to use for the system";
    };

    initrd = {
      enableTweaks = mkEnableOption "quality of life tweaks for the initrd stage";
      optimizeCompressor = mkEnableOption ''
        initrd compression algorithm optimizations for size.
        Enabling this option will force initrd to use zstd (default) with
        level 19 and -T0 (STDIN). This will reduce the initrd size greatly
        at the cost of compression speed.
        Not recommended for low-end hardware.
      '';
    };

    silentBoot =
      mkEnableOption ''
        almost entirely silent boot process through `quiet` kernel parameter
      ''
      // {
        default = cfg.plymouth.enable;
      };
  };

  config = {
    boot = {
      consoleLogLevel = 3;

      kernelPackages = mkDefault cfg.kernel;

      loader = {
        # if set to 0, space needs to be held to get the boot menu to appear
        timeout = mkForce 2;

        # copy boot files to /boot so that /nix/store is not required to boot
        # it takes up more space but it makes my messups a bit safer
        generationsDir.copyKernels = true;

        # we need to allow installation to modify EFI variables
        efi.canTouchEfiVariables = true;
      };

      # increase the map count, this is important for applications that require a lot of memory mappings
      # such as games and emulators
      kernel.sysctl."vm.max_map_count" = 2147483642;

      initrd = mkMerge [
        (mkIf cfg.initrd.enableTweaks {
          # Verbosity of the initrd
          # disabling verbosity removes only the mandatory messages generated by the NixOS
          verbose = false;

          systemd = {
            # enable systemd in initrd (experimental)
            enable = true;

            # strip copied binaries and libraries from inframs
            # saves some nice space
            strip = true;
          };

          kernelModules = [
            "nvme"
            "xhci_pci"
            "ahci"
            "btrfs"
            "sd_mod"
            "dm_mod"
          ];

          availableKernelModules = [
            "vmd"
            "usbhid"
            "sd_mod"
            "sr_mod"
            "dm_mod"
            "uas"
            "usb_storage"
            "ata_piix"
            "virtio_pci"
            "virtio_scsi"
            "ehci_pci"
          ];
        })

        (mkIf cfg.initrd.optimizeCompressor {
          compressor = "zstd";
          compressorArgs = [
            "-19"
            "-T0"
          ];
        })
      ];

      # https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html
      kernelParams =
        optionals cfg.enableKernelTweaks [
          # https://en.wikipedia.org/wiki/Kernel_page-table_isolation
          # auto means kernel will automatically decide the pti state
          "pti=auto" # on || off

          # enable IOMMU for devices used in passthrough and provide better host performance
          "iommu=pt"

          # disable usb autosuspend
          "usbcore.autosuspend=-1"

          # allow systemd to set and save the backlight state
          "acpi_backlight=native"

          # prevent the kernel from blanking plymouth out of the fb
          "fbcon=nodefer"

          # disable boot logo
          "logo.nologo"

          # disable the cursor in vt to get a black screen during intermissions
          "vt.global_cursor_default=0"
        ]
        ++ optionals cfg.silentBoot [
          # tell the kernel to not be verbose, the voices are too loud
          "quiet"

          # kernel log message level
          "loglevel=3" # 1: system is unusable | 3: error condition | 7: very verbose

          # udev log message level
          "udev.log_level=3"

          # lower the udev log level to show only errors or worse
          "rd.udev.log_level=3"

          # disable systemd status messages
          # rd prefix means systemd-udev will be used instead of initrd
          "systemd.show_status=auto"
          "rd.systemd.show_status=auto"
        ];
    };
  };
}
