{lib, ...}: let
  inherit (lib.attrsets) getAttrFromPath;
  inherit
    (builtins)
    elem
    filter
    hasAttr
    any
    ;
  /*
  *
  a function that will append a list of groups if they exist in config.users.groups

  # Arguments

  - [config] the configuration that nixosConfigurations provides
  - [groups] a list of groups to check for

  # Type

  ```
  ifTheyExist :: AttrSet -> List -> List
  ```

  # Example

  ```nix
  ifTheyExist config ["wheel" "users"]
  => ["wheel"]
  ```
  */
  ifTheyExist = config: groups: filter (group: hasAttr group config.users.groups) groups;

  /*
  *
  convenience function check if the declared device type is of an accepted type

  # Arguments

  - [config] the configuration that nixosConfigurations provides
  - [list] a list of devices that will be accepted

  # Type

  ```
  isAcceptedDevice :: AttrSet -> List -> Bool
  ```

  # Example

  ```nix
  isAcceptedDevice osConfig ["foo" "bar"]
  => false
  ```
  */
  isAcceptedDevice = conf: list: elem conf.olympus.device.type list;

  /*
  *
  check if the device is wayland-ready

  # Arguments

  - [config] the configuration that nixosConfigurations provides

  # Type

  ```
  isWayland :: AttrSet -> Bool
  ```

  # Example

  ```nix
  isWayland osConfig
  => true
  ```
  */
  isWayland = conf: conf.olympus.meta.isWayland;

  /*
  *
  check if the device is modernShell-ready

  # Arguments

  - [config] the configuration that nixosConfigurations provides

  # Type

  ```
  isModernShell :: AttrSet -> Bool
  ```

  # Example

  ```nix
  isModernShell osConfig
  => true
  ```
  */
  isModernShell = conf: conf.olympus.programs.cli.enable && conf.olympus.programs.cli.modernShell.enable;

  anyHome = conf: cond: path: let
    list =
      map (
        user:
          getAttrFromPath (
            [
              "users"
              user
            ]
            ++ path
          )
          conf
      )
      conf.olympus.system.users;
  in
    any cond list;
in {
  inherit
    ifTheyExist
    isAcceptedDevice
    isWayland
    isModernShell
    anyHome
    ;
}
