{ pkgs, lib, config, ... }: {

  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify =
   let
     spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
   in
   {
     enable = true;
     enabledExtensions = with spicePkgs.extensions; [
      
       hidePodcasts
     ];
     theme = spicePkgs.themes.comfy;
     colorScheme = "Hikari";
   }
}