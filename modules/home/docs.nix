{lib, ...}: let
  inherit (lib.attrsets) mapAttrs;
  inherit (lib.modules) mkForce;
in {
  manual = mapAttrs (_: mkForce) {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };
}
