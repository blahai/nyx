{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    wezterm-git
  ];

  xdg.configFile."wezterm" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/pingu/.config/nixos/modules/home-manager/cli/wezterm";
    recursive = true;
  };
}
