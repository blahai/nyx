{ inputs, config, pkgs, lib, ... }:
{
  imports = [
    ../../modules/home-manager/default.nix
  ];

  home.username = "pingu";
  home.homeDirectory = "/home/pingu";

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  home.stateVersion = "24.05";

  home.packages = [

  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
