{ inputs, config, pkgs, ... }:

{
  imports = [
    ../../modules/home-manager/hypr/default.nix
    ../../modules/nixos/games/default.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "pingu";
  home.homeDirectory = "/home/pingu";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/pingu/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    XMODIFIERS = "@im=ibus";
    GTK_IM_MODULE = "ibus";
    QT_IM_MODULE = "ibus"
    QT_QPA_PLATFORMTHEME = "qt5ct";
    WLR_NO_HARDWARE_CURSORS = "1";
    GSK_RENDERER = "cairo";

    MOZ_ENABLE_WAYLAND = "1";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";

    _JAVA_AWT_WM_NONREPARENTING = "1"
    XCURSOR_THEME = "Bibata-Modern-Classic";
    HYPRCURSOR_THEME = "HyprBibataModernClassicSVG"
    XCURSOR_SIZE, 24
    __GL_THREADED_OPTIMIZATIONS, 0
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
