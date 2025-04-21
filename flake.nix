{
  description = "Elissa's funny little flake";

  nixConfig = {
    auto-optimise-store = true;
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    #nixpkgs.url = "path:/home/pingu/Documents/GitHub/NixOS/nixpkgs";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    # to keep lix up to date
    lix = {
      url = "https://git.lix.systems/lix-project/lix/archive/main.tar.gz";
      inputs = {nixpkgs.follows = "nixpkgs";};
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        lix.follows = "lix";
      };
    };

    haipkgs = {
      url = "github:blahai/haipkgs";
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

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
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

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = {
    nixpkgs,
    lix-module,
    chaotic,
    home-manager,
    haipkgs,
    ...
  } @ inputs: {
    nixosConfigurations = {
      nyx = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
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
        };
        modules = [
          ./hosts/epimetheus/configuration.nix
          lix-module.nixosModules.default
        ];
      };
    };
  };
}
