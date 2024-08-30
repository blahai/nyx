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
      "Super, Q, exec, ${pkgs.foot}/bin/foot"
      "Super, C, killactive"
      "Super, V, togglefloating"
      "Super, E, exec, ${pkgs.nautilus} --new-window"
      
      # This horror of a mess is from having more than 10 workspaces and I'm very much considering just removing this shit
    ] ++ map (n: "Alt, ${toString n}, exec, ~/.config/ags/scripts/hyprland/workspace_adction.sh movetoworkspacesilent ${toString (
        if n == 0
        then 10
        else n
      )}") [1 2 3 4 5 6 7 8 9 0]
      ++ map (n: "Super, ${toString n}, exec, ~/.config/ags/scripts/hyprland/workspace_adction.sh workspace, ${toString (
        if n == 0
        then 10
        else n
      )}") [1 2 3 4 5 6 7 8 9 0];

  };
}