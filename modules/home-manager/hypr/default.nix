{ pkgs, config, inputs, ... }: { 

  imports = [
    ./hyprland/rules.nix
    ./hyprland/keybinds.nix
    ./hyprland/execs.nix
    ./hyprlock.nix
    ../ags/default.nix
  ];

  # apparently hyprcursor doesn't work with hm?
  environment.systemPackages = [ pkgs.hyprcursor ];
  home.packages = with pkgs; [
    hyprshot
    hyprpicker
    wlr-randr
    wl-clipboard
    brightnessctl
    xwayland
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    qt5ct
    qt6ct
    swww
    mpvpaper
  ];

  home.file."~/.config/hypr/colors.conf" = {
    text = ''
      general {
        col.active_border = rgba(DFE2EF39)
        col.inactive_border = rgba(8C909F30)
      }

      misc {
        background_color = rgba(0F131CFF)
      }

      windowrulev2 = bordercolor rgba(ADC6FFAA) rgba(ADC6FF77),pinned:1
    '';
    checkPhase = ''
      if [ -f "$out" ]; then
        echo "File already exists, skipping creation"
        exit 0
      fi
    '';
  };


  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;

    settings = {
      monitor = [
        ",prefered,auto,1"
      ];

      input = {
        kb_layout = "us,fi";
        kb_options = "caps:escape, grp:win_space_toggle";
        repeat_delay = 250;
        repeat_rate = 35;
        follow_mouse = 1;
        sensitivity = 0.1;
        force_no_accel = true;
      };

      general = {
        # Gaps and border
        gaps_in = 4;
        gaps_out = 5;
        gaps_workspaces = 50;
        border_size = 3;

        # Fallback colours
        "col.active_border" = "rgba(0DB7D4FF)";
        "col.inactive_border" = "rgba(31313600)";

        resize_on_border = true;
        no_focus_fallback = true;
        layout = "dwindle";
      };

      dwindle = {
        preserve_split = true;
        smart_split = false;
        smart_resizing = false;
        special_scale_factor = 0.9;
      };

      decoration = {
        rounding = 15;

        blur = {
          enable = true;
          xray = true;
          special = true;
          new_optimizations = true;
          size = 14;
          passes = 4;
          brightness = 1;
          noise = 0.05;
          contrast = 1;
          popups = true;
          popups_ignorealpha = 0.6;
        };
        # Shadow
        drop_shadow = true;
        shadow_ignore_window = true;
        shadow_range = 20;
        shadow_offset = 0 2;
        shadow_render_power = 4;
        "col.shadow" = "rgba(0000002A)";


        # Dim
        dim_inactive = false;
        dim_strength = 0.1;
        dim_special = 0;
      };

      animations = {
        enabled = true;
        bezier = [
          "linear, 0, 0, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "menu_decel, 0.1, 1, 0, 1"
          "menu_accel, 0.38, 0.04, 1, 0.07"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "fluent_decel, 0.1, 1, 0, 1"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
          "softAcDecel, 0.26, 0.26, 0.15, 1"
          "md2, 0.4, 0, 0.2, 1"
        ];
        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "windowsIn, 1, 3, md3_decel, popin 60%"
          "windowsOut, 1, 3, md3_accel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 3, md3_decel"
          "layersIn, 1, 3, menu_decel, slide"
          "layersOut, 1, 1.6, menu_accel"
          "fadeLayersIn, 1, 2, menu_decel"
          "fadeLayersOut, 1, 4.5, menu_accel"
          "workspaces, 1, 7, menu_decel, slide"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };

      misc = {
        vfr = 1;
        vrr = 2;
        
        focus_on_activate = true;
        animate_manual_resizes = false;
        animate_mouse_windowdragging = false;
        enable_swallow = false;
        swallow_regex = "(foot|kitty|allacritty|Alacritty)";

        disable_hyprland_logo = true;
        force_default_wallpaper = 0;
        new_window_takes_over_fullscreen = 2;
        allow_session_lock_restore = true;

        initial_workspace_tracking = false;
      };

    };

  };

}