{ config, lib, ... }: {
  imports = [
    ./cli/default.nix
    ./hypr/default.nix
    ./ags/default.nix
  ];
}
