{ modulesPath, lib, pkgs, ... }: {
  system.stateVersion = "24.11";
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.initrd.availableKernelModules = [ "virtio_scsi" "ahci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.loader.grub = {
    enable = true;
  };

  networking = {
    useDHCP = lib.mkDefault false;
    defaultGateway = {
      address = "178.63.247.183";
      interface = "ens3";
    };

    interfaces = {
      ens3 = {
        ipv4 = {
          addresses = [
            {
              address = "178.63.118.252";
              prefixLength = 32;
            }
          ];

          routes = [
            {
              address = "178.63.247.183";
              prefixLength = 32;
            }
          ];
        };
      };
    };
  };

  services.openssh = {
    enable = true;
  };

  users.users.root = { 
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILPbmiNqoyeKXk/VopFm2cFfEnV4cKCFBhbhyYB69Fuu elissa.tamminen@gmail.com"
    ];
    initialHashedPassword = "$y$j9T$TzqbL4iMGLjli6EEXfRCZ0$AhFJ4iCFxRlstth5owic3M5nq74Sp1qhtctjSBcgAl8";
  };
}
