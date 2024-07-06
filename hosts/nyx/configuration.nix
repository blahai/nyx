{ pkgs, config, ... }: {
  imports = [
    ./hardware-configuration.nix

      
  ];

  # Bootloader.
  boot = {
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot = {
      enable = true;
      consoleMode = "auto";
    };
    tmp.cleanOnBoot = true;
    kernelPackages =
      pkgs.linuxPackages_zen; # _zen, _hardened, _rt, _rt_latest, etc.
  };

  # Networking
  networking.networkmanager.enable = true;
  networking.hostName = "nyx";

  # Timezone and locale
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

  # Users
  users.users.pingu = {
    isNormalUser = true;
    description = "Elissa";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };
  defaultUserShell = pkgs.zsh;

  services = {
    xserver = {
      enable = true;
      displayManager.sddm.enable = true;
      xkb = { 
        layout = "us,fi";
        variant = "euro";
        options = "caps:escape, grp:win_space_toggle";
      };
    };
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;
  };

  # Set environment variables
  environment.variables = {
    XDG_DATA_HOME = "$HOME/.local/share";
    PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
    MOZ_ENABLE_WAYLAND = "1";
    EDITOR = "nvim";
    ANKI_WAYLAND = "1";
    DISABLE_QT5_COMPAT = "0";
    NIXOS_OZONE_WL = "1";
  };

  # Sound
  sound = { enable = true; };

  security.rtkit.enable = true;
  hardware.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
    gc = {
      automatic = true;
      persistent = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    } else
      { };
  };

  nixpkgs.config.allowUnfree = true;

  xdg.portal = {
    enable = true;
    configPackages = with pkgs; [ 
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland 
    ];
  };

  services.libinput.enable = true;
  programs.dconf.enable = true;

  # Faster rebuilding
  documentation = {
    enable = true;
    doc.enable = false;
    man.enable = true;
    dev.enable = false;
  };

  services.dbus.enable = true;

  # Don't touch this
  system.stateVersion = "24.05";
}