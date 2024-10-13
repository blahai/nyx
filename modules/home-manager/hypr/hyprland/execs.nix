{ pkgs, config, inputs, ... }: {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "${pkgs.swww}/bin/swww-daemon --format xrgb"
      "ags"
    ];
  };
}
