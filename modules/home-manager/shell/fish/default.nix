{ config, lib, pkgs, ... }:
{
  programs.fish = {
    enable = true;

  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zoxide.enable = true;

  services.atuin.enable = true;


}
