{ config, modulesPath, lib, pkgs, ... }: {
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
    kernelPackages = pkgs.linuxPackages_6_12;
    kernelModules = [ "kvm-amd" ];
    kernel = {
      sysctl = {
        "vm.max_map_count" = 2147483642;
        "net.ipv4.ip_forward" = 1;
        "net.ipv6.conf.all.forwarding" = 1;
      };
    };
    extraModulePackages = [ ];
    loader.grub = {
      enable = true;
      device = "/dev/vda";
    };
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "netdata" ];

  nix = {
    package = pkgs.lix;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      sandbox = true;
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
    enableIPv6 = false; # Had to disable for now due to problems with resolving
    firewall = {
      allowedTCPPorts = [
        80 # HTTP
        443 # HTTPS
        222 # git over ssh
        25565 # minecraft
      ];
      allowedUDPPorts = [
        25565 # minecraft
      ];
    };
    hostName = "theia";
    nameservers = [ "1.1.1.1" "8.8.8.8" "9.9.9.9" ];
    domain = "theia.blahai.gay";
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
    tailscale = {
      enable = true;
      useRoutingFeatures = "server";
      openFirewall = true;
    };

    networkd-dispatcher = {
      enable = true;
      rules."50-tailscale" = {
        onState = [ "routable" ];
        script = ''
          ${lib.getExe pkgs.ethtool} -K ens3 rx-udp-gro-forwarding on rx-gro-list off
        '';
      };
    };

    earlyoom = {
      enable = true;
      extraArgs = let
        avoid = lib.concatStringsSep "|" [
          "cryptsetup"
          "dbus-.*"
          "gpg-agent"
          "ssh-agent"
          "sshd"
          "systemd"
          "systemd-.*"
          "bash"
          "fish"
          "n?vim"
        ];
        prefer =
          lib.concatStringsSep "|" [ "dotnet" "java.*" "nix" "npm" "node" ];
      in [
        "-g"
        "--avoid '(^|/)(${avoid})'" # things that we want to avoid killing
        "--prefer '(^|/)(${prefer})'" # things we want to remove fast
      ];

    };

    caddy = {
      enable = true;
      virtualHosts = {
        "git.blahai.gay" = {
          extraConfig = ''
            reverse_proxy localhost:3000
          '';
        };

        "vault.blahai.gay" = {
          extraConfig = ''
            reverse_proxy localhost:8222 {
              header_up X-Real-IP {remote_host}
            }
          '';
        };

        "search.blahai.gay" = {
          extraConfig = ''
            reverse_proxy localhost:8888
          '';
        };

        "kuma.blahai.gay" = {
          extraConfig = ''
            reverse_proxy localhost:3001
          '';
        };

        "status.blahai.gay" = {
          extraConfig = ''
            reverse_proxy localhost:19999
          '';
        };
      };
    };

    uptime-kuma = {
      enable = true;
      settings = { PORT = "3001"; };
    };

    netdata = {
      enable = true;
      config.global = {
        "memory mode" = "ram";
        "debug log" = "none";
        "access log" = "none";
        "error log" = "syslog";
      };
      package = pkgs.netdata.override { withCloudUi = true; };
    };

    forgejo = {
      package = pkgs.forgejo;
      enable = true;
      settings = {
        DEFAULT.APP_NAME = "githai";
        federation.ENABLED = true;
        server = {
          ROOT_URL = "https://git.blahai.gay";
          DOMAIN = "git.blahai.gay";
          SSH_PORT = 222;
          SSH_LISTEN_PORT = 222;
        };
      };
    };

    vaultwarden = {
      enable = true;
      config = {
        DOMAIN = "https://vault.blahai.gay";
        ROCKET_PORT = 8222;
      };
    };

    searx = {
      enable = true;
      redisCreateLocally = true;
      settings = {
        use_default_settings = true;
        server = {
          port = 8888;
          secret_key =
            "7360d3df7c08ce681cf6d5122e3e182de2c5205e962766abd3e6dfc8dec1b683";
        };
        ui = { infinite_scroll = true; };

        general = {
          instance_name = "searchai";
          debug = false;
        };
        search = {
          safe_search = 0;
          autocomplete = "google";
          default_lang = "en";
        };
      };
    };

    openssh = {
      enable = true;
      openFirewall = true;
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

  programs = { nix-ld.enable = true; };

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

  users.users.minecraft = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILPbmiNqoyeKXk/VopFm2cFfEnV4cKCFBhbhyYB69Fuu" # nyx
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILLqPq70t6RbnI8UejEshYcfBP66I4OrLFjvGLLfIEXD" # laptop
    ];
    packages = with pkgs; [
      openjdk21
      openjdk17
      screen

    ];
    initialHashedPassword =
      "$y$j9T$KpQYYLB6eWfHAUo9.o/uy1$gnj/UlWLrx5XBZDm2GNdjHs2G5D3XxxqqtrCIf5MX43";
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
    fish
    ethtool
    networkd-dispatcher
  ];
}
