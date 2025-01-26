{inputs, ...}: {
  imports = [
    # home manager has been a pia to work with and
    # gives really hard to debug errors so I just
    # gave up with it so hjem it is
    # inputs.home-manager.nixosModules.home-manager
    inputs.hjem.nixosModules.default
    inputs.hjem-rum.nixosModules.default
    inputs.lix-module.nixosModules.default
  ];
}
