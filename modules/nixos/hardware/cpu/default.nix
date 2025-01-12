{lib, ...}: let
  inherit (lib) mkOption types;
in {
  imports = [
    ./amd.nix
  ];

  options.olympus.device.cpu = mkOption {
    type = types.nullOr (
      types.enum [
        "amd"
      ]
    );
    default = null;
    description = "CPU brand";
  };
}
