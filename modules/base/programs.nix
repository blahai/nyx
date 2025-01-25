{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.meta) getExe;

  bashPrompt = ''
    eval "$(${getExe pkgs.starship} init bash)"
  '';
in {
  # home-manager is so strange and needs these declared multiple times
  programs = {
    fish.enable = config.olympus.programs.fish.enable;
    zsh.enable = config.olympus.programs.zsh.enable;
  };
}
