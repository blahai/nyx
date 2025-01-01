{
  pkgs,
  config,
  inputs,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    bindle = [
      ",XF86AudioMute, exec, playerctl --player=spotify,%any play-pause"
      ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ];

    bindm = ["Super, mouse:272, movewindow" "Super, mouse:273, resizewindow"];

    bindn = [" , up, pass, JKPS"];

    binde = [
      # Window split ratio
      "Super, Semicolon, splitratio, -0.1"
      "Super, Apostrophe, splitratio, 0.1"
    ];

    bind =
      [
        "Super, mouse_up, workspace, +1"
        "Super, mouse_down, workspace, -1"
        "Super, Page_up, workspace, -1"
        "Super, Page_down, workspace, +1"

        "Super+Shift, S, togglespecialworkspace"

        "Super, R, exec, ${pkgs.anyrun}/bin/anyrun"
        "Super, W, exec, ${pkgs.floorp}/bin/floorp"
        "Super, Q, exec, wezterm"
        "Super, Return, exec, ghostty"
        "Super, C, killactive"
        "Super, V, togglefloating"
        "Super, E, exec, ${pkgs.nautilus}/bin/nautilus -w"
        "SUPERALT, V, exec, pkill fuzzel || cliphist list | fuzzel --icon-theme=candy-icons --background-color=1A1513dd --text-color=F8D4D2ff --match-color=FFB3B1ff --border-width=2 --border-radius=15 --border-color=EB8A89ff	 --selection-color=585b70ff --selection-text-color=F8D4D2ff --selection-match-color=FFB3B1ff --font='Lexend'  --prompt='>>  ' --dmenu | cliphist decode | wl-copy"

        "Super, L, exec, ${pkgs.hyprlock}/bin/hyprlock"

        # recording and ss stuff
        "Super, S, exec, pkill slurp || grimblast --freeze copy area"

        # ags stuff
        "Super + Control, R, exec, pkill ags; ags"
        "Super, Tab, exec, ags -t launcher"
        "Super, X, exec, ags -t powermenu"

        ## Hyprland stuff
        "Super, Z, movewindow"

        # Swap windows
        "Super+Shift, left, movewindow, l"
        "Super+Shift, right, movewindow, r"
        "Super+Shift, up, movewindow, u"
        "Super+Shift, down, movewindow, d"

        # Move focus
        "Super, left, movefocus, l"
        "Super, right, movefocus, r"
        "Super, up, movefocus, u"
        "Super, down, movefocus, d"

        # Fullscreen
        "Super+Shift, F, fullscreen, 0"
      ]
      ++ map (n: "Alt, ${toString n}, movetoworkspacesilent, ${
        toString (
          if n == 0
          then 10
          else n
        )
      }") [1 2 3 4 5 6 7 8 9 0]
      ++ map (n: "Super, ${toString n}, workspace, ${
        toString (
          if n == 0
          then 10
          else n
        )
      }") [1 2 3 4 5 6 7 8 9 0];
  };
}
