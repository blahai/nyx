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
    ../../home/system/hypr


  ];

  home = {
    username = "pingu";
    homeDirectory = "/home/pingu/";

    packages = with pkgs; [
      # Stuff
      obsidian
      vscode
      firefox

      # Idk
      bitwarden
      vesktop
      nextcloud-client

      # Dev Stuff
      gcc
      go
      cargo
      jq
      git
      git-ignore
      nodejs
      bun

      # Media
      jellyfin-media-player
      mpv
      vlc
      eog
      
    ];
}
