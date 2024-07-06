{ pkgs, config, inputs, ... }: {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "${pkgs.floorp}/bin/floorp"
      "${pkgs.vesktop}/bin/vesktop"
      "${pkgs.hyprland}/bin/hyprctl setcursor Bibata-Modern-Classic 24"
    ];
  };
}