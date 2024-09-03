{ inputs, pkgs, lib, ... }: {
  # add the home manager module
  imports = [ inputs.ags.homeManagerModules.default ];

  home.packages = with pkgs; [
    gnome.gnome-control-center
    blueberry
    gammastep
    gnome.gnome-bluetooth
    material-symbols
    gnome-usage
    ddcutil
    inotify-tools
    ollama
    pywal
    dart-sass
    hicolor-icon-theme
    yad
    fuzzel
    gradience
    adw-gtk3
    (python311.withPackages (p: [
      p.material-color-utilities
      p.pywayland
      p.materialyoucolor
      p.libsass
    ]))
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
      hicolor-icon-theme
      gnome-usage
      gtksourceview
      gtksourceview4
      ollama
      python311Packages.material-color-utilities
      python311Packages.pywayland
      pywal
      dart-sass
      webkitgtk
      webp-pixbuf-loader
      ydotool
    ];
  };
}
