{
  description = "Elissa's funny little flake";

  nixConfig = {
    auto-optimise-store = true;
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-smol.url = "github:nixos/nixpkgs?ref=nixos-unstable-small";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    haipkgs = {
      url = "git+https://gitlab.blahai.gay/elissa/haipkgs.git";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    haivim = {
      url = "github:blahai/haivim";
      inputs = {nixpkgs.follows = "nixpkgs";};
    };

    ags = {
      url = "github:Aylur/ags/v1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {url = "github:catppuccin/nix";};

    hyprland.url = "github:hyprwm/Hyprland";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = {
    nixpkgs,
    nixpkgs-smol,
    lix-module,
    chaotic,
    home-manager,
    haipkgs,
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
          lix-module.nixosModules.default
          home-manager.nixosModules.default
          chaotic.nixosModules.default
          haipkgs.nixosModules.default
        ];
      };

      epimetheus = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          pkgs-smol = import nixpkgs-smol {inherit system;};
        };
        modules = [
          ./hosts/epimetheus/configuration.nix
          lix-module.nixosModules.default
        ];
      };
    };
  };
}
