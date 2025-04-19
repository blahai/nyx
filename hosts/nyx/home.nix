{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home-manager/default.nix
    inputs.catppuccin.homeModules.catppuccin
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
      format = "ssh";
    };
    extraConfig = {
      core = {
        editor = "nvim";
        autocrlf = "input";
      };
      url = {
        "ssh://git@github.com/" = {insteadOf = "https://github.com/";};
      };
      init = {defaultBranch = "main";};
      format = {
        signOff = true;
      };
    };
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host artemis
        HostName 100.106.17.39
        User pingu

      Host selene
        HostName 135.181.31.235
        User pingu
    '';
  };

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "WhiteSur";
      package = pkgs.whitesur-icon-theme.override {
        boldPanelIcons = true;
        alternativeIcons = true;
      };
    };
    gtk4.extraCss = config.gtk.gtk3.extraCss;
    gtk3.extraCss = ''
      @define-color mauve #cba6f7;
      @define-color red #f38ba8;
      @define-color green #a6e3a1;
      @define-color text #cdd6f4;
      @define-color surface_0 #313244;
      @define-color base #1e1e2e;
      @define-color crust #11111b;

      @define-color accent_color @mauve;
      @define-color accent_bg_color @mauve;
      @define-color accent_fg_color @crust;

      @define-color window_bg_color @base;
      @define-color window_fg_color @text;

      @define-color headerbar_bg_color @base;
      @define-color headerbar_fg_color @text;

      @define-color popover_bg_color @surface_0;
      @define-color popover_fg_color @text;

      @define-color dialog_bg_color @popover_bg_color;
      @define-color dialog_fg_color @popover_fg_color;

      @define-color sidebar_bg_color @base;
      @define-color sidebar_fg_color @text;
      @define-color sidebar_backdrop_color @base;
      @define-color sidebar_shade_color RGB(0 0 6 / 25%);
      @define-color sidebar_border_color RGB(0 0 6 / 36%);

      @define-color secondary_sidebar_bg_color @sidebar_backdrop_color;
      @define-color secondary_sidebar_fg_color @text;
      @define-color secondary_sidebar_backdrop_color @sidebar_backdrop_color;
      @define-color secondary_sidebar_shade_color @sidebar_shade_color;
      @define-color secondary_sidebar_border_color @sidebar_border_color;

      @define-color view_bg_color @base;
      @define-color view_fg_color @text;

      @define-color card_bg_color @surface_0;
      @define-color card_fg_color @text;

      @define-color thumbnail_bg_color @surface_0;
      @define-color thumbnail_fg_color @text;

      @define-color warning_bg_color @red;
      @define-color warning_fg_color @text;
      @define-color warning_color @red;
      @define-color error_bg_color @red;
      @define-color error_fg_color @text;
      @define-color error_color @red;
      @define-color success_bg_color @green;
      @define-color success_fg_color @text;
      @define-color success_color @green;
      @define-color destructive_bg_color @red;
      @define-color destructive_fg_color @crust;
      @define-color destructive_color @red;

      :root {
        --accent-bg-color: @accent_bg_color;
        --accent-fg-color: @accent_fg_color;

        --destructive-bg-color: @destructive_bg_color;
        --destructive-fg-color: @destructive_fg_color;

        --success-bg-color: @success_bg_color;
        --success-fg-color: @success_fg_color;

        --warning-bg-color: @warning_bg_color;
        --warning-fg-color: @warning_fg_color;

        --error-bg-color: @error_bg_color;
        --error-fg-color: @error_fg_color;

        --window-bg-color: @window_bg_color;
        --window-fg-color: @window_fg_color;

        --view-bg-color: @view_bg_color;
        --view-fg-color: @view_fg_color;

        --headerbar-bg-color: @headerbar_bg_color;
        --headerbar-fg-color: @headerbar_fg_color;
        --headerbar-border-color: @headerbar_border_color;
        --headerbar-backdrop-color: @headerbar_backdrop_color;
        --headerbar-shade-color: @headerbar_shade_color;
        --headerbar-darker-shade-color: @headerbar_darker_shade_color;

        --sidebar-bg-color: @sidebar_bg_color;
        --sidebar-fg-color: @sidebar_fg_color;
        --sidebar-backdrop-color: @sidebar_backdrop_color;
        --sidebar-border-color: @sidebar_border_color;
        --sidebar-shade-color: @sidebar_shade_color;

        --secondary-sidebar-bg-color: @secondary_sidebar_bg_color;
        --secondary-sidebar-fg-color: @secondary_sidebar_fg_color;
        --secondary-sidebar-backdrop-color: @secondary_sidebar_backdrop_color;
        --secondary-sidebar-border-color: @secondary_sidebar_border_color;
        --secondary-sidebar-shade-color: @secondary_sidebar_shade_color;

        --card-bg-color: @card_bg_color;
        --card-fg-color: @card_fg_color;
        --card-shade-color: @card_shade_color;

        --dialog-bg-color: @dialog_bg_color;
        --dialog-fg-color: @dialog_fg_color;

        --popover-bg-color: @popover_bg_color;
        --popover-fg-color: @popover_fg_color;
        --popover-shade-color: @popover_shade_color;

        --thumbnail-bg-color: @thumbnail_bg_color;
        --thumbnail-fg-color: @thumbnail_fg_color;

        --shade-color: @shade_color;
        --scrollbar-outline-color: @scrollbar_outline_color;

        --thumbnail-bg-color: @thumbnail_bg_color;
        --thumbnail-fg-color: @thumbnail_fg_color;
      }
    '';
  };

  catppuccin = {
    kvantum = {
      enable = true;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    obsidian
    inputs.haivim.packages.${pkgs.system}.default
    mold
    clang
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  home.file.".cargo/config.toml".text = ''
    [target.x86_64-unknown-linux-gnu]
    linker = "clang"
    rustflags = ["-C", "link-arg=-fuse-ld=${pkgs.mold}/bin/mold"]
  '';

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
