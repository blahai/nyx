{ pkgs, config, inputs, lib, ... }:
{
  wayland.windowManager.hyprland.settings = {
    
    workspace = [
      "special:special, on-created-empty:exec spotify"
    ];

    windowrule = [
      "noblur,.*"
      "workspace special, spotify"
      "workspace 3 silent, vesktop"
      "workspace 1 silent, floorp"
      "float, ^(blueberry.py)$"
    ];

    windowrulev2 = [
      
    ];

    layerrule = [
      "layerrule = xray 0, .*"
      "layerrule = noanim, walker"
      "layerrule = noanim, selection"
      "layerrule = noanim, overview"
      "layerrule = noanim, anyrun"
      "layerrule = noanim, indicator.*"
      "layerrule = noanim, osk"
      "layerrule = noanim, hyprpicker"
      "layerrule = blur, shell:*"
      "layerrule = ignorealpha 0.6, shell:*"

      "layerrule = blur, eww"
      "layerrule = ignorealpha 0.8, eww"
      "layerrule = noanim, noanim"
      "layerrule = blur, noanim"
      "layerrule = blur, gtk-layer-shell"
      "layerrule = ignorezero, gtk-layer-shell"
      "layerrule = blur, launcher"
      "layerrule = ignorealpha 0.5, launcher"
      "layerrule = blur, notifications"
      "layerrule = ignorealpha 0.69, notifications"

      "layerrule = animation slide top, sideleft.*"
      "layerrule = animation slide top, sideright.*"
      "layerrule = blur, session"

      "layerrule = blur, bar"
      "layerrule = ignorealpha 0.20, bar"
      "layerrule = blur, corner.*"
      "layerrule = ignorealpha 0.20, corner.*"
      "layerrule = blur, dock"
      "layerrule = ignorealpha 0.20, dock"
      "layerrule = blur, indicator.*"
      "layerrule = ignorealpha 0.20, indicator.*"
      "layerrule = blur, overview"
      "layerrule = ignorealpha 0.20, overview"
      "layerrule = blur, cheatsheet"
      "layerrule = ignorealpha 0.20, cheatsheet"
      "layerrule = blur, sideright"
      "layerrule = ignorealpha 0.20, sideright"
      "layerrule = blur, sideleft"
      "layerrule = ignorealpha 0.20, sideleft"
      "layerrule = blur, indicator*:"
      "layerrule = ignorealpha 0.20, indicator*"
      "layerrule = blur, osk"
      "layerrule = ignorealpha 0.20, osk"
    ];

  };
}