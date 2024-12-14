{ inputs, config, pkgs, ... }: {
  imports = [
    ../../modules/home-manager/default.nix
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  home.username = "pingu";
  home.homeDirectory = "/home/pingu";

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "blahai";
    userEmail = "github@blahai.gay";
    diff-so-fancy.enable = true;
    signing = {
      signByDefault = true;
      key = "/home/pingu/.ssh/id_ed25519";
    };
    extraConfig = {
      core = {
        editor = "nvim";
        autocrlf = "input";
      };
      url = {
        "ssh://git@github.com/" = { insteadOf = "https://github.com/"; };
      };
      gpg = { format = "ssh"; };
      init = { defaultBranch = "main"; };
    };
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host theia
        HostName 178.63.118.252
        User pingu

      Host artemis
        HostName 100.106.17.39
        User pingu
    '';
  };

  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      flavor = "mocha";
      accent = "pink";
      size = "standard";
      tweaks = [ "normal" ];
      icon.enable = true;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  home.stateVersion = "24.11";

  home.packages = with pkgs; [ obsidian ];

  home.sessionVariables = { EDITOR = "nvim"; };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
