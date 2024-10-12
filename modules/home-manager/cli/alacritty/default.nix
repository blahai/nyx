{ pkgs, lib, config } :
{
  programs.alacritty = {
    enable = true;
    
    settings = {
      window.opacity = 0.9;
      padding = { x = 5; y = 5; };
    };
  };
}
