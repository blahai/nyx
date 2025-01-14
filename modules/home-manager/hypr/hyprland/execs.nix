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
      "sleep 1; ${pkgs.vesktop}/bin/vesktop --ozone-platform-hint=auto --enable-blink-features=MiddleClickAutoscroll --enable-wayland-ime=true"
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
      "JKPS"
      "ags"
    ];
  };
}
