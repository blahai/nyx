{
  description = "Elissa's funny little flake";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://nixpkgs-unfree.cachix.org"
      "https://hyprland.cachix.org/"
      "https://anyrun.cachix.org"
      "https://wezterm.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="
    ];

    auto-optimise-store = true;
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-smol.url = "github:nixos/nixpkgs?ref=nixos-unstable-small";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nur.url = "github:nix-community/NUR";

    # This is a private repository for now while I work on it
    # My plan is to make it public by the end of the year
    # for now have a look at https://github.com/redyf/Neve
    # as that is where I *borrowed* the base from
    haivim = {
      url = "git+ssh://git@github.com/blahai/haivim";
      inputs = {nixpkgs.follows = "nixpkgs";};
    };

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:Aylur/ags/v1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wezterm.url = "github:wez/wezterm?dir=nix";

    catppuccin = {url = "github:catppuccin/nix";};

    hyprland.url = "github:hyprwm/Hyprland";

    zen-browser.url = "github:ch4og/zen-browser-flake";
  };

  outputs = {
    nixpkgs,
    nixpkgs-smol,
    chaotic,
    home-manager,
    disko,
    ...
  } @ inputs: let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      nyx = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          pkgs-smol = import nixpkgs-smol {
            inherit system;
            config.allowUnfree = true;
          };
        };
        modules = [
          ./hosts/nyx/configuration.nix
          inputs.home-manager.nixosModules.default
          chaotic.nixosModules.default
        ];
      };

      # helios = nixpkgs.lib.nixosSystem {
      #   modules = [
      #     ./hosts/helios/configuration.nix
      #     # inputs.home-manager.nixosModules.default
      #     chaotic.nixosModules.default
      #   ];
      # };

      theia = nixpkgs.lib.nixosSystem {
        modules = [./hosts/theia/configuration.nix disko.nixosModules.disko];
      };

      epimetheus = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          pkgs-smol = import nixpkgs-smol {inherit system;};
        };
        modules = [./hosts/epimetheus/configuration.nix disko.nixosModules.disko];
      };
    };
  };
}
