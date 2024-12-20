{
  inputs,
  pkgs,
  lib,
  ...
}: {
  # add the home manager module
  imports = [inputs.ags.homeManagerModules.default];

  home.packages = with pkgs; [
    bun
    dart-sass
    sassc
    swww
    fd
    brightnessctl
    slurp
    wl-clipboard
    swappy
    hyprpicker
    pwvucontrol
    which
    python312Packages.gpustat
  ];

  programs.ags = {
    enable = true;

    # null or path, leave as null if you don't want hm to manage the config
    # configDir = ../ags;
    configDir = null;

    # additional packages to add to gjs's runtime
    extraPackages = with pkgs; [
      accountsservice
      gtk-session-lock
    ];
  };
}
