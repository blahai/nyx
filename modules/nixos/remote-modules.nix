{inputs, ...}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.lix-module.nixosModules.default
  ];
}
