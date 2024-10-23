{ inputs, pkgs, lib, config, ... }: 
{
  home.packages = with pkgs; [
    inputs.wezterm.packages.${pkgs.system}.default
  ];
  
  xdg.configFile."wezterm" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/pingu/.config/nixos/modules/home-manager/cli/wezterm";
    recursive = true;
  };
}
