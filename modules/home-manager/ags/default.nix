{ inputs, pkgs, lib, ... }: {
  # add the home manager module
  imports = [ inputs.ags.homeManagerModules.default ];

  home.packages = with pkgs; [
    bun
    dart-sass
    fd
    brightnessctl
    swww
    inputs.matugen.packages.${system}.default
    slurp
    wl-clipboard
    wayshot
    swappy
    hyprpicker
    pavucontrol
    networkmanager
    gtk3
  ];

  #home.activation = {
  #  linkAgs = lib.hm.dag.entryAfter ["writeBoundary"] ''
  #    ln -sf ~/.config/nixos/modules/home-manager/ags/ags ~/.config/ags
  #  '';
  #};

  programs.ags = {
    enable = true;

    # null or path, leave as null if you don't want hm to manage the config
    # configDir = ../ags;
    configDir = null;

    # additional packages to add to gjs's runtime
    extraPackages = with pkgs; [
      accountsservice
    ];
  };
}
