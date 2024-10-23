{ pkgs, config, inputs, ... }: {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "${pkgs.swww}/bin/swww-daemon --format xrgb"
      "${pkgs.floorp}/bin/floorp"
      "sleep 3; ${pkgs.vesktop}/bin/vesktop"
      "ags"
    ];
  };
}
