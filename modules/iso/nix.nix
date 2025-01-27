{config, ...}: {
  # We don't want to alter the iso image itself so we prevent rebuilds
  system.switch.enable = false;

  nix = {
    # we can disable channels since we can just use the flake
    channel.enable = false;

    # we need to have nixpkgs in our path
    nixPath = ["nixpkgs=${config.nix.registry.nixpkgs.to.path}"];

    settings = {
      experimental-features = [
        "flakes"
        "nix-command"
        "auto-allocate-uids"
      ];

      # more logging is nice when doing installs, we want to know if something goes wrong
      log-lines = 50;

      # A unimportant warning in this case
      warn-dirty = false;

      # Its nice to have more http downloads when setting up
      http-connections = 50;

      # We can ignore the flake registry since we won't be using it
      # this is because we already have all the programs we need in the ISO
      flake-registry = "";

      # we don't need this nor do we want it
      accept-flake-config = false;

      # this is not important when your in a ISO
      auto-optimise-store = false;

      # fetch from a cache if we can
      substituters = [
        "https://nix-community.cachix.org"
        "https://nixpkgs-unfree.cachix.org"
        "https://hyprland.cachix.org"
        "https://wezterm.cachix.org"
      ];

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="
      ];
    };
  };
}
