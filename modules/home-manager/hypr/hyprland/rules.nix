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
      "xray 0, .*"
      "noanim, walker"
      "noanim, selection"
      "noanim, overview"
      "noanim, anyrun"
      "noanim, indicator.*"
      "noanim, osk"
      "noanim, hyprpicker"
      "blur, shell:*"
      "ignorealpha 0.6, shell:*"

      "blur, eww"
      "ignorealpha 0.8, eww"
      "noanim, noanim"
      "blur, noanim"
      "blur, gtk-layer-shell"
      "ignorezero, gtk-layer-shell"
      "blur, launcher"
      "ignorealpha 0.5, launcher"
      "blur, notifications"
      "ignorealpha 0.69, notifications"
 
      "animation slide top, sideleft.*"
      "animation slide top, sideright.*"
      "blur, session"

      "blur, bar"
      "ignorealpha 0.20, bar"
      "blur, corner.*"
      "ignorealpha 0.20, corner.*"
      "blur, dock"
      "ignorealpha 0.20, dock"
      "blur, indicator.*"
      "ignorealpha 0.20, indicator.*"
      "blur, overview"
      "ignorealpha 0.20, overview"
      "blur, cheatsheet"
      "ignorealpha 0.20, cheatsheet"
      "blur, sideright"
      "ignorealpha 0.20, sideright"
      "blur, sideleft"
      "ignorealpha 0.20, sideleft"
      "blur, indicator*:"
      "ignorealpha 0.20, indicator*"
      "blur, osk"
      "ignorealpha 0.20, osk"
    ];

  };
}
