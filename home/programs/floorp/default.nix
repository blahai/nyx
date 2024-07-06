{ config, pkgs, ...}: {
  home.packages = with pkgs; [
    floorp
  ];

  # One day this will be done, but that day is not today

}