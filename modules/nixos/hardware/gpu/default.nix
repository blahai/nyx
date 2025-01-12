{lib, ...}: let
  inherit (lib) mkOption types;
in {
  imports = [
    ./amd.nix
    ./novideo.nix
  ];

  options.olympus.device.gpu = mkOption {
    type = types.nullOr (
      types.enum [
        "amd"
        "nvidia"
        "hybrid-nv"
      ]
    );
    default = null;
    description = "GPU brand";
  };
}
