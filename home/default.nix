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
in {
  hjem = {
    users = genAttrs config.olympus.system.users (name: ./${name});

    clobberByDefault = true;
  };
}
