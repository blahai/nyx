{ pkgs, lib, modulesPath, config, ... }: {

  imports = [ "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix" ];

  boot = {
    kernelPackages = pkgs.linuxPackages_6_12;
    kernelParams = lib.mkAfter [ "noquiet" "toram" ];
    enableContainers = false;
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  environment.systemPackages = with pkgs; [
    # The essentials
    neovim
    disko
    parted
    git
    nixd
    pciutils
    
    # The installers
    arch-install-scripts # For arch and it's 
    xbps # Void linux
    dnf5 # Fedora
    debootstrap # Debin and ubuntu
    apt # Ubuntu
    
  ];

  documentation = {
    enable = lib.mkDefault false;
    doc.enable = lib.mkDefault false;
    info.enable = lib.mkDefault false;
  };

  networking = {
    networkmanager.enable = true;
    wireless.enable = lib.mkForce false;
  };

  services = {
    logrotate.enable = false;
    udisks2.enable = false;
  };

  programs = {
    less.lessopen = null;
    command-not-found.enable = false;
  };

  environment = {
    stub-ld.enable = lib.mkForce false;
    defaultPackages = [ ];
  };

  xdg = {
    autostart.enable = false;
    icons.enable = false;
    mime.enable = false;
    sounds.enable = false;
  };

  nix = {
    package = pkgs.lix;
    nixPath = [ "nixpkgs=${config.nix.registry.nixpkgs.to.path}" ];
    channel.enable = false;
    settings = {
      experimental-features = [ "nix-command" "flakes" "auto-allocate-uids" ];
      max-jobs = "auto";
      sandbox = true;
      auto-optimise-store = true;
      keep-going = true;
      warn-dirty = false;
      use-xdg-base-directories = true;
      substituters = [
        "https://nix-community.cachix.org"
        "https://nixpkgs-unfree.cachix.org"
        "https://hyprland.cachix.org/"
        "https://anyrun.cachix.org"
        "https://wezterm.cachix.org"
      ];
      trusted-public-keys = [ 
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
        "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="
      ];

    };
  };

  hardware.enableRedistributableFirmware = true;

}
