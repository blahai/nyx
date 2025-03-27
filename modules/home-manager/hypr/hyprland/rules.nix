_: {
  wayland.windowManager.hyprland.settings = {
    workspace = [
      "special:special, on-created-empty:exec spotify --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime=true"
    ];

    windowrule = [
      "workspace special, class:spotify"
      # "workspace 11 silent, class:JKPS"
      "workspace 10 silent, class:(org.qbittorrent.qBittorrent)"
      "workspace 6 silent, class:firefox"
      "workspace 5 silent, class:(org.prismlauncher.PrismLauncher)"
      "workspace 3 silent, class:vesktop"
      "workspace 2 silent, class:steam"
      "workspace 1 silent, class:floorp"
      "noblur, class:(org.wezfurlong.wezterm)"
    ];

    layerrule = [
      "xray 0, .*"
      "noanim, selection"
      "noanim, overview"
      "noanim, anyrun"
      "noanim, indicator.*"
      "noanim, osk"
      "noanim, hyprpicker"
      "blur, shell:*"
      "ignorealpha 0.6, shell:*"

      "noanim, noanim"
      "blur, noanim"
      "blur, gtk-layer-shell"
      "ignorezero, gtk-layer-shell"
      "blur, launcher"
      "ignorealpha 0.5, launcher"
      "blur, notifications"
      "ignorealpha 0.69, notifications"

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
