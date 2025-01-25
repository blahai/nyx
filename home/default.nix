{
  lib,
  self,
  self',
  config,
  inputs,
  inputs',
  ...
}: let
  inherit (lib.modules) mkDefault;
  inherit (lib.attrsets) genAttrs;
  inherit (config.olympus.programs) defaults;
in {
  home-manager = {
    verbose = true;
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "bak";

    extraSpecialArgs = {
      inherit
        inputs
        self
        inputs'
        self'
        defaults
        ;
    };

    users = genAttrs config.olympus.system.users (name: ./${name});

    # we should define grauntied common modules here
    sharedModules = [
      {
        home.stateVersion = config.system.stateVersion;

        # reload system units when changing configs
        systemd.user.startServices = mkDefault "sd-switch"; # or "legacy" if "sd-switch" breaks again

        # let HM manage itself when in standalone mode
        programs.home-manager.enable = true;
      }
    ];
  };
}
