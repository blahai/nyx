{lib, ...}: let
  inherit (lib.modules) mkDefault;
in {
  system = {
    stateVersion = mkDefault "25.05";
  };
}
