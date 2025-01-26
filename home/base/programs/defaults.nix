{lib, ...}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) enum nullOr;
in {
  options.olympus.programs.defaults = {
    shell = mkOption {
      type = enum [
        "bash"
        "fish"
      ];
      default = "bash";
    };

    terminal = mkOption {
      type = enum [
        "alacritty"
        "kitty"
        "wezterm"
        "foot"
      ];
      default = "wezterm";
    };

    fileManager = mkOption {
      type = enum [
        "cosmic-files"
        "thunar"
        "dolphin"
        "nemo"
        "nautilus"
      ];
      default = "nautilus";
    };

    browser = mkOption {
      type = enum [
        "firefox"
        "floorp"
        "chromium"
        "thorium"
      ];
      default = "floorp";
    };

    editor = mkOption {
      type = enum [
        "nvim"
      ];
      default = "nvim";
    };

    launcher = mkOption {
      type = nullOr (enum [
        "rofi"
        "wofi"
        "cosmic-launcher"
      ]);
      default = "wofi";
    };

    bar = mkOption {
      type = nullOr (enum [
        "waybar"
        "ags"
      ]);
      default = "ags";
    };

    screenLocker = mkOption {
      type = nullOr (enum [
        "hyprlock"
        "swaylock"
        "gtklock"
        "cosmic-greeter"
      ]);
      default = "hyprlock";
      description = ''
        The lockscreen module to be loaded by hjem.
      '';
    };

    noiseSuppressor = mkOption {
      type = nullOr (enum [
        "rnnoise"
        "noisetorch"
      ]);
      default = "rnnoise";
      description = ''
        The noise suppressor to be used for desktop systems with sound enabled.
      '';
    };
  };
}
