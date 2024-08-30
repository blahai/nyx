{ inputs, options, config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    foot
    swww
    mpvpaper
    libnotify
    cliphist
    wl-clipboard
    fzf
    fuzzel
    pywal
    yad
    jq
    python312Packages.pywayland 
    python312Packages.psutil
    python312Packages.pillow
    python312Packages.wheel
    python312Packages.materialyoucolor
    python312Packages.libsass
    python312Packages.material-color-utilities
    dart-sass
    hyprlock
    hyprpicker
  ];
    
  #wayland.windowManager.hyprland = {
  #  enable = true; 
  #};
}
