{ pkgs, lib, config, ... }:
{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "sixel";
        source = "~/Pictures/nix-Wallpaper.png";
        width = 32;
      };

      display = {
        separator = "  ";
      };

      modules = [
        {
            type = "custom";
            format = "┌─────────── \u001b[1mHardware Information\u001b[0m ───────────┐";
        }
        {
            type = "cpu";
            key = "  ";
        }
        {
            type = "gpu";
            key = "  ﬙";
        }
        {
            type = "memory";
            key = "  󰑭";
        }
        {
            type = "swap";
            key = "  󰓡";
        }
        {
            type = "custom";
            format = "├─────────── \u001b[1mSoftware Information\u001b[0m ───────────┤";
        }
        {
            type = "title";
            key = "  ";
            format = "{1}@{2}";
        }
        {
            type = "os";
            key = "  ";
        }
        {
            type = "kernel";
            key = "  ";
            format = "{1} {2}";
        }
        {
            type = "wm";
            key =  "";
        }
        {
            type = "shell";
            key = "  ";
        }
        {
            type = "terminal";
            key = "  ";
        }
        {
            type = "uptime";
            key = "  󰅐";
        }
        {
            type = "media",;
            key = "  󰝚";
        }
        {
            type = "custom";
            format = "└────────────────────────────────────────────┘";
        }
        {
            type = "colors";
            paddingLeft = 2;
            symbol = "circle";
        }
      ];
    };
  };
}
