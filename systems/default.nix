{
  self,
  inputs,
  lib,
  ...
}: let
  # inherit (self) lib;
  inherit (lib.lists) optionals;

  profilesPath = ../modules/profiles;
  # Hardware profiles
  desktop = profilesPath + /desktop;
  server = profilesPath + /server;
  laptop = profilesPath + /laptop;

  # Meta profiles
  graphical = profilesPath + /graphical;
  headless = profilesPath + /headless;
in {
  imports = [inputs.easy-hosts.flakeModule];

  config.easyHosts = {
    shared.specialArgs = {inherit lib;};

    perClass = class: {
      modules = [
        # import the class module, this contains the common configurations between all systems of the same class
        "${self}/modules/${class}/default.nix"

        (optionals (class != "iso") [
          # import the home module, which is users for configuring users via home-manager
          "${self}/home/default.nix"

          # import the base module, this contains the common configurations between all systems
          "${self}/modules/base/default.nix"
        ])
      ];
    };

    # the defaults consists of the following:
    #  arch = "x86_64";
    #  class = "nixos";
    #  deployable = false;
    #  modules = [ ];
    #  specialArgs = { };
    hosts = {
      # Elissa's desktop
      nyx.modules = [
        desktop
        graphical
      ];

      # Elissa's laptop
      helios.modules = [
        laptop
        graphical
      ];

      # Other desktop (will set up later)
      aphrodite.modules = [
        desktop
        graphical
      ];

      # Server
      theia = {
        deployable = true;
        modules = [
          server
          headless
        ];
      };

      # ISO
      epimetheus = {
        class = "iso";
        modules = [headless];
      };
    };
  };
}
