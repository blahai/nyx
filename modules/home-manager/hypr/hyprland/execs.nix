{
  pkgs,
  config,
  inputs,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "${pkgs.swww}/bin/swww-daemon --format xrgb"
      "${pkgs.floorp}/bin/floorp"
      "${pkgs.qbittorrent}/bin/qbittorrent"
      "vesktop"
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
      # "JKPS"
      "ags"
    ];
  };
}
