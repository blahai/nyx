{ pkgs, modulesPath, ... }: {

  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  boot.kernelPackages = pkgs.linuxPackages_6_11;

  nixpkgs.hostPlatform = "x86_64-linux";

  environment.systemPackages = with pkgs; [
    neovim
    disko
    parted
    git
    nixd
  ];

  networking = {
    networkmanager.enable = true;
    wireless.enable = true;
  };

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
    };
  };

}
