{
  pkgs,
  lib,
  modulesPath,
  config,
  ...
}: {
  imports = ["${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"];

  boot = {
    kernelPackages = pkgs.linuxPackages_6_12;
    kernelParams = lib.mkAfter ["noquiet" "toram"];
    enableContainers = false;
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  environment.systemPackages = with pkgs; [
    # The essentials
    neovim
    parted
    git
    pciutils
  ];

  documentation = {
    enable = lib.mkForce false;
    doc.enable = lib.mkForce false;
    info.enable = lib.mkForce false;
  };

  networking = {
    networkmanager.enable = true;
    wireless.enable = lib.mkForce false;
  };

  services = {
    logrotate.enable = false;
    udisks2.enable = false;
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "yes";
      };
    };
  };

  users.users = {
    root = {
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILPbmiNqoyeKXk/VopFm2cFfEnV4cKCFBhbhyYB69Fuu"
      ];
    };
  };

  programs = {
    less.lessopen = null;
    command-not-found.enable = false;
  };

  environment = {
    stub-ld.enable = lib.mkForce false;
    defaultPackages = [];
  };

  xdg = {
    autostart.enable = false;
    icons.enable = false;
    mime.enable = false;
    sounds.enable = false;
  };

  nix = {
    nixPath = ["nixpkgs=${config.nix.registry.nixpkgs.to.path}"];
    channel.enable = false;
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
      warn-dirty = false;
      use-xdg-base-directories = true;
      substituters = [
        "https://nix-community.cachix.org"
        "https://nixpkgs-unfree.cachix.org"
        "https://hyprland.cachix.org/"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
  };

  hardware.enableRedistributableFirmware = true;
}
