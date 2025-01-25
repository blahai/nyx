{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkDefault;
  inherit (lib.attrsets) genAttrs;
  inherit (builtins) filter hasAttr;
  ifTheyExist = config: groups: filter (group: hasAttr group config.users.groups) groups;
in {
  users.users = genAttrs config.olympus.system.users (
    name: {
      home = "/home/" + name;
      shell = config.olympus.programs.${config.olympus.programs.defaults.shell}.package;

      uid = mkDefault 1000;
      isNormalUser = true;
      initialPassword = mkDefault "changeme";

      # only add groups that exist
      extraGroups =
        [
          "wheel"
          "nix"
        ]
        ++ ifTheyExist config [
          "network"
          "networkmanager"
          "systemd-journal"
          "audio"
          "pipewire"
          "video"
          "input"
          "plugdev"
          "tss"
          "power"
          "mysql"
          "docker"
          "git"
          "libvirtd"
          "cloudflared"
        ];
    }
  );
}
