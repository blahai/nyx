{
  description = "Elissa's funny little flake";

  nixConfig = {
    auto-optimise-store = true;
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-smol.url = "github:nixos/nixpkgs?ref=nixos-unstable-small";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nur.url = "github:nix-community/NUR";

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
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
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
