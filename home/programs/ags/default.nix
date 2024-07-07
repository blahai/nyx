{ config, lib, pkgs, ... }: {
  home.packages = with pkgs {
    ags
    gjs
    typescript
    meson
    npm
    fuzzel
    bc
    cliphist
    bibata-cursors
    adw-gtk3
  };

  
}
