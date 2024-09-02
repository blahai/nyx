{ pkgs, config, inputs, ... }: {
  wayland.windowManager.hyprland.settings = {
    
    bindm = [
      "Super, mouse:272, movewindow"
      "Super, mouse:273, resizewindow"
    ];

    bind = [
      "Super, mouse_up, workspace, +1"
      "Super, mouse_down, workspace, -1"

      "Super+Shift, S, togglespecialworkspace"

      "Super, W, exec, ${pkgs.floorp}/bin/floorp"
      "Super, Q, exec, ${pkgs.foot}/bin/foot"
      "Super, C, killactive"
      "Super, V, togglefloating"
      "Super, E, exec, ${pkgs.nautilus}/bin/nautilus -w"
      "SUPERALT, V, exec, pkill fuzzel || cliphist list | fuzzel --no-fuzzy --icon-theme=candy-icons --background-color=1A1513dd --text-color=F8D4D2ff --match-color=FFB3B1ff --border-width=2 --border-radius=15 --border-color=EB8A89ff	 --selection-color=585b70ff --selection-text-color=F8D4D2ff --selection-match-color=FFB3B1ff --font='Lexend'  --prompt='>>  ' --dmenu | cliphist decode | wl-copy"

      "Super, L, exec, ${pkgs.hyprlock}/bin/hyprlock"

      # AGS
      "Super, Tab, exec, ags -t 'toggleAppsWindow()'"
      "Super, A, exec, ags -t "
      "Super, D, exec, ags -t sidebar"
      "Control+Super, R, exec, pkill ags ; ags &"
      "Control+Super, T, exec, ~/.config/ags/scripts/color_generation/switchwall.sh"
      "Super, X, exec, for ((i=0; i<$(hyprctl monitors -j | jq length); i++)); do ags -t 'session''$i'; done"

      # recording and ss stuff
      "Super, S, exec, pkill slurp || grimblast --freeze copysave area -"

      
    ] ++ map (n: "Alt, ${toString n}, exec, movetoworkspacesilent ${toString (
        if n == 0
        then 10
        else n
      )}") [1 2 3 4 5 6 7 8 9 0]
      ++ map (n: "Super, ${toString n}, exec, workspace, ${toString (
        if n == 0
        then 10
        else n
      )}") [1 2 3 4 5 6 7 8 9 0];

  };
}
