{ inputs, config, pkgs, lib, ... }:
{
  imports = [
    ../../modules/home-manager/default.nix
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  home.username = "pingu";
  home.homeDirectory = "/home/pingu";

  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      flavor = "mocha";
      accent = "pink";
      size = "standard";
      tweaks = [ "normal" ];
      icon.enable = true;
    };
  };
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    obsidian
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
