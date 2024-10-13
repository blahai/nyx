{ pkgs, lib, config, ... }: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        include = "${pkgs.foot.themes}/share/foot/themes/catppuccin-mocha";
        term = "xterm-256color";
        title = "foot";
        font = "SpaceMono Nerd Font:size=11";
        letter-spacing = 0;
        pad = "25x25";
      };
      cursor = {
        color = "11111b f5e0dc";
        style = "beam";
        beam-thickness = 1.5;
      };
      colors = { alpha = 0.9; };
    };
  };
}
