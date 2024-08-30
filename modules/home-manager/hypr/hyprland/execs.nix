{ pkgs, config, inputs, ... }: {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "${pkgs.swww}/bin/swww-daemon --format xrgb"
      "${pkgs.mpvpaper}/bin/mpvpaper DP-1 -f -o 'loop panscan=1.0' ~/Pictures/wallpapers/videos/current"
      "${pkgs.ags}/bin/ags &"
      "${pkgs.floorp}/bin/floorp"
      "${pkgs.vesktop}/bin/vesktop"
      "${pkgs.hyprland}/bin/hyprctl setcursor Bibata-Modern-Classic 24"

    ];
  };
}