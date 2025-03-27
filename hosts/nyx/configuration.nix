{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/default.nix
    inputs.home-manager.nixosModules.default
  ];

  documentation.nixos.enable = false;

  boot = {
    tmp.cleanOnBoot = true;
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = ["zfs" "ext4" "btrfs"];
    zfs = {
      forceImportRoot = false;
      extraPools = ["zpool" "zootfs" "zepool"];
      devNodes = "/dev/disk/by-id";
      package = pkgs.zfs;
      allowHibernation = true; # might cause corruption?
    };
    kernelPackages = pkgs.linuxPackages_6_12;
    kernel = {sysctl = {"vm.max_map_count" = 2147483642;};};
    kernelParams = [
      "elevator=none" # for zfs
      "zfs.zfs_arc_max=8589934592"
      "nvme.noacpi=1"
    ];
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 75;
  };

  networking = {
    hostName = "nyx";
    hostId =
      builtins.substring 0 8
      (builtins.hashString "md5" config.networking.hostName);
    networkmanager.enable = true;
    stevenblack = {
      enable = true;
      block = ["fakenews" "gambling"];
    };
    nameservers = ["1.1.1.1" "1.0.0.1" "9.9.9.9"];
  };

  time.timeZone = "Europe/Helsinki";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fi_FI.UTF-8";
    LC_IDENTIFICATION = "fi_FI.UTF-8";
    LC_MEASUREMENT = "fi_FI.UTF-8";
    LC_MONETARY = "fi_FI.UTF-8";
    LC_NAME = "fi_FI.UTF-8";
    LC_NUMERIC = "fi_FI.UTF-8";
    LC_PAPER = "fi_FI.UTF-8";
    LC_TELEPHONE = "fi_FI.UTF-8";
    LC_TIME = "fi_FI.UTF-8";
  };

  environment.etc."greetd/hyprland.conf".text = ''
    exec-once = ${pkgs.greetd.regreet}/bin/regreet; hyprctl dispatch exit

    animations {
      enabled = false
    }

    misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true
        disable_hyprland_qtutils_check = true
    }
  '';

  services = {
    greetd = {
      settings = {
        default_session = {
          command = "${config.programs.hyprland.package}/bin/Hyprland --config /etc/greetd/hyprland.conf";
        };
      };
    };

    xserver = {
      enable = false;
      excludePackages = [pkgs.xterm];
    };

    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
  };

  security.rtkit.enable = true;

  users.users = {
    pingu = {
      isNormalUser = true;
      description = "Elissa";
      extraGroups = [
        "networkmanager"
        "wheel"
        "input"
        "render"
        "jellyfin"
      ];
      shell = pkgs.bash;
      packages = with pkgs; [
        floorp
        vesktop-git
      ];
    };
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    useGlobalPkgs = true;
    useUserPackages = true;
    verbose = true;
    backupFileExtension = "bak";
    users = {"pingu" = import ./home.nix;};
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  programs = {
    firefox.enable = true;

    nautilus-open-any-terminal = {
      enable = true;
      terminal = "wezterm";
    };

    fish.enable = true;

    regreet = {
      enable = true;
      settings = {
        background = {
          path = ../../files/nix-Wallpaper.png;
          fit = "Cover";
        };
        GTK = {
          application_prefer_dark_theme = true;
        };
      };
    };

    hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
      portalPackage = inputs.hyprland.packages."${pkgs.system}".xdg-desktop-portal-hyprland;
    };

    direnv = {enable = true;};

    nh = {
      enable = true;
      flake = "/home/pingu/.config/nixos";
      clean = {
        enable = true;
        extraArgs = "--keep-since 5d --keep 5";
      };
    };

    nix-ld.enable = true;

    git = {
      enable = true;
      lfs.enable = true;
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
  };

  nix = {
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "auto-allocate-uids"
        "recursive-nix"
        "ca-derivations"
        "dynamic-derivations"
        "fetch-closure"
      ];
      max-jobs = "auto";
      sandbox = true;
      auto-optimise-store = true;
      keep-going = true;
      fallback = true;
      warn-dirty = false;
      allow-import-from-derivation = true;
      use-xdg-base-directories = true;
      allowed-users = ["@wheel" "pingu" "root"];
      trusted-users = ["@wheel" "pingu" "root"];
      substituters = [
        "https://nix-community.cachix.org"
        "https://nixpkgs-unfree.cachix.org"
        # "https://haipkgs.cachix.org"
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
        # "haipkgs.cachix.org-1:AcjMqIafTEQ7dw99RpeTJU2ywNUn1h8yIxz2+zjpK/A="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
  };

  qt.enable = true;

  environment = {
    sessionVariables = {
      NAUTILUS_4_EXTENSION_DIR = "${pkgs.nautilus-python}/lib/nautilus/extensions-4";
      GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" (with pkgs.gst_all_1; [
        gst-plugins-good
        gst-plugins-bad
        gst-plugins-ugly
        gst-libav
      ]);
    };
    pathsToLink = [
      "/share/nautilus-python/extensions"
    ];

    systemPackages = with pkgs; [
      nautilus
      nautilus-python
      diff-so-fancy
      eog
      bottles
      ffmpeg
      gst_all_1.gstreamer
      gst_all_1.gst-libav
      gst_all_1.gst-vaapi
      gst_all_1.gst-plugins-base
      gst_all_1.gst-plugins-rs
      celluloid
      mpv
      age
      ssh-to-age
      inputs.zen-browser.packages."${pkgs.system}".default
      cava
      socat
      btrfs-progs
      btop-rocm
      rocmPackages.rocm-smi
      hyprcursor
      grimblast
      neovim
      wget
      git
      curl
      fish
      fastfetch
      zoxide
      starship
      cachix
      gcc
      ripgrep
      clang
      ninja
      go
      lua
      lua-language-server
      nix-output-monitor
      alejandra
      comma
      zip
      nodejs
      busybox
      rustup
      bibata-cursors
      spotify
      jq
      gnome-control-center
      pavucontrol
      icon-library
      bat
      fzf
      fd
      eza
      glib
      cliphist
      playerctl
      imagemagick
      wireguard-tools
      mission-center
      speedcrunch
      geogebra
      qbittorrent
    ];
  };
  fonts.packages = with pkgs; [
    iosevka-comfy.comfy
    fira-code
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    nerd-fonts.symbols-only
    google-fonts
    material-symbols
    material-icons
    material-design-icons
    maple-mono.variable
    maple-mono.NF
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.fwupd.enable = true;
  services.smartd = {
    enable = true;
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  system.stateVersion = "24.05";
}
