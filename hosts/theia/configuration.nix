{ modulesPath, lib, pkgs, ... }: {
  system.stateVersion = "24.11";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  boot = {
    initrd.availableKernelModules = [
      "ata_piix"
      "uhci_hcd"
      "virtio_pci"
      "virtio_scsi"
      "ahci"
      "sd_mod"
      "sr_mod"
      "virtio_blk"
    ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
    loader.grub = {
      enable = true;
      device = "/dev/vda";
    };
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/09e65ff9-2195-41d8-b6a4-671c306742c3";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/FED3-A372";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  networking = {
    hostName = "theia";
    useDHCP = lib.mkDefault false;
    defaultGateway = {
      address = "178.63.247.183";
      interface = "ens3";
    };

    interfaces = {
      ens3 = {
        ipv4 = {
          addresses = [{
            address = "178.63.118.252";
            prefixLength = 32;
          }];

          routes = [{
            address = "178.63.247.183";
            prefixLength = 32;
          }];
        };
      };
    };
  };

  services = {
    openssh = {
      enable = true;
      settings = { PasswordAuthentication = false; };
    };

    fail2ban = {
      enable = true;
      maxretry = 5;
      bantime = "24h"; # Ban IPs for one day on the first ban
      bantime-increment = {
        enable = true; # Enable increment of bantime after each violation
        overalljails = true; # Calculate the bantime based on all the violations
      };
    };
  };

  users.users.root = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILPbmiNqoyeKXk/VopFm2cFfEnV4cKCFBhbhyYB69Fuu"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILLqPq70t6RbnI8UejEshYcfBP66I4OrLFjvGLLfIEXD"
    ];
    initialHashedPassword =
      "$y$j9T$TzqbL4iMGLjli6EEXfRCZ0$AhFJ4iCFxRlstth5owic3M5nq74Sp1qhtctjSBcgAl8";
  };

  users.users.pingu = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILPbmiNqoyeKXk/VopFm2cFfEnV4cKCFBhbhyYB69Fuu"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILLqPq70t6RbnI8UejEshYcfBP66I4OrLFjvGLLfIEXD"
    ];
    initialHashedPassword =
      "$y$j9T$cxwKGmzYyC1eLeIysr8r/.$dsxxxV4NvXY.Wpd9LO.RiuMQuy2lYyy2HGrk52BJX08";
  };

  environment.systemPackages = with pkgs; [
    git
    curl
    bat
    neovim
    btop
    zip
    jq
    busybox
  ];
}
