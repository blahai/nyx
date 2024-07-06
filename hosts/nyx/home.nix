{ pkgs, config, ... }: {

  imports = [
    # Programs
    ../../home/programs/ags
    ../../home/programs/games
    ../../home/programs/floorp
    ../../home/programs/nvim
    ../../home/programs/shell
    ../../home/programs/
    ../../home/programs/

    # System
    ../../home/system/gtk
    ../../home/system/mime


  ];

  home = {
    packages = with pkgs; [
      # Stuff
      obsidian
      vscode
      firefox

      # Media
      jellyfin-media-player
      
    ];
}