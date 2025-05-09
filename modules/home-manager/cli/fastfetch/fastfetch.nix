{
  pkgs,
  lib,
  config,
  ...
}: {
  home.file."Pictures/gay.png".source = ./gay.png;
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "kitty";
        source = "~/Pictures/gay.png";
        width = 32;
      };

      display = {separator = "  ";};

      modules = [
        {
          type = "custom";
          format = "┌─────────── Hardware Information ───────────┐";
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
          format = "├─────────── Software Information ───────────┤";
        }
        {
          type = "title";
          key = "  ";
          format = "{1}@{2}";
        }
        {
          type = "os";
          key = "  ";
        }
        {
          type = "kernel";
          key = "  ";
          format = "{1} {2}";
        }
        {
          type = "wm";
          key = "  ";
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
          type = "media";
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
