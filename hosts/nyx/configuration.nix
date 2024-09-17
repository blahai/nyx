{ config, pkgs, inputs, system, lib, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../../modules/nixos/games/default.nix
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
    kernelPackages = pkgs.linuxPackages_zen;
  };

  networking = {
    hostName = "nyx";
    networkmanager.enable = true;
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
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      floorp
      vesktop

    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    verbose = true;
    users = {
      "pingu" = import ./home.nix;
    };
  };

  virtualisation.docker.enable = true;

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

    };

    nix-ld.enable = true;

    git = {
      enable = true;
      lfs.enable = true;

    };
  };

  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      substituters = [
        "https://hyprland.cachix.org"
        "https://cache.nixos.org"
        "https://nixpkgs-wayland.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      trusted-users = [ "@wheel" "pingu" "root" ];
    };
    gc = {
      automatic = true;
      persistent = true;
      dates = "daily";
      options = "--delete-older-than +5";
    };
  };

  environment.systemPackages = with pkgs; [
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
    gnome.gnome-control-center
    pavucontrol
    icon-library
    bat
    fzf
    fd
    eza
    glib
    cliphist
    playerctl
    socat
    adwaita-qt6
    material-icons
    material-design-icons
    material-symbols
    ddcutil
    (python311.withPackages (ps: with ps; [ 
      pillow
      material-color-utilities
      materialyoucolor
      wheel
      setuptools-scm
      libsass
      pywayland
      psutil
      numpy
      requests
      pyxdg
    ]))
    pywal
    dart-sass
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
