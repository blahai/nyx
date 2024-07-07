{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;

    packages = with pkgs; [
      # icon fonts
      material-symbols

      # Sans(Serif) fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      roboto
      
      # IDK
      rubik
      lexend

      nerdfonts = (pkgs.nerdfonts.override {
        fonts = [
          "Ubuntu"
          "UbuntuMono"
          "CascadiaCode"
          "FantasqueSansMono"
          "JetBrainsMono"
          "FiraCode"
          "Mononoki"
          "SpaceMono"
        ];
      });

      google-fonts = (pkgs.google-fonts.override {
        fonts = [
          # Sans
          "Gabarito" "Lexend"
          # Serif
          "Chakra Petch" "Crimson Text"
        ];
      });
    ];

    fontconfig.defaultFonts =
      let
        addAll = builtins.mapAttrs (k: v: [ "Symbols Nerd Font" ] ++ v ++ [ "Noto Color Emoji" ]);
      in
      addAll {
        serif = [ "Noto Serif" "Noto Serif CJK SC" ];
        sansSerif = [ "Noto Sans" "Noto Sans CJK SC" ];
        monospace = [ "JetBrains Mono" ];
        emoji = [ ];
      };
  };
}
