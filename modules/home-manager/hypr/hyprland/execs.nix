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
      "sleep 1; ${pkgs.vesktop}/bin/vesktop --ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --enable-wayland-ime=true"
      "exec-once = wl-paste --type text --watch cliphist store"
      "exec-once = wl-paste --type image --watch cliphist store"
      "JKPS"
      "ags"
    ];
  };
}
