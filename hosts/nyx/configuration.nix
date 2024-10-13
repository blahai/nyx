{ config, pkgs, inputs, system, lib, ... }:

{
  imports =
    [ 
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
    kernelPackages = pkgs.linuxPackages_cachyos;
    kernel = {
      sysctl ={
        "vm.max_map_count" = 2147483642;
      };
    };
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 75;
  };

  networking = {
    hostName = "nyx";
    networkmanager.enable = true;
    stevenblack = {
      enable = true;
      block = [
      "fakenews"
      "gambling"
      ];
    };
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "9.9.9.9"
    ];
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

  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      xkb = {
        layout = "us";
        variant = "euro";
      };
    };
    
    gnome.gnome-keyring.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  users.users.pingu = {
    isNormalUser = true;
    description = "Elissa";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      floorp
      vesktop
      alacritty
      kitty
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    verbose = true;
    backupFileExtension = "bak";
    users = {
      "pingu" = import ./home.nix;
    };
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
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
    
    fish.enable = true;

    hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
      portalPackage = inputs.hyprland.packages."${pkgs.system}".hyprland;
    };
    
    direnv = {
      enable = true;
    };
    
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

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.lix;
    settings = {
      experimental-features = [ "nix-command" "flakes" "auto-allocate-uids" ];
      max-jobs = "auto";
      sandbox = true;
      auto-optimise-store = true;
      keep-going = true;
      warn-dirty = false;
      use-xdg-base-directories = true;
      trusted-users = [ "@wheel" "pingu" "root" ];
    };
  };

  environment.systemPackages = with pkgs; [
    btrfs-progs
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
    go
    lua
    lua-language-server
    nil
    nixfmt-classic
    zip
    nodejs
    typescript
    busybox
    rustup
    vscode-fhs
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
    material-icons
    material-design-icons
    material-symbols
    imagemagick
  ];

  fonts.packages = with pkgs; [
    iosevka-comfy.comfy
    fira-code
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    nerdfonts
    google-fonts
    material-symbols
    material-icons
    maple-mono
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
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
