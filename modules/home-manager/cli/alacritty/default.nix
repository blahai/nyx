{ pkgs, lib, config, ... } :
{
  programs.alacritty = {
    enable = true;
    
    settings = {
      window = {
        opacity = 0.9;
        dynamic_padding = true;
        padding = {
          x = 5;
          y = 5;
        };
      };
      font = {
        normal = {
          family = "SpaceMono Nerd Font";
          style = "Regular";
        };
      };
    };
  };
}
