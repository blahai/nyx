{ inputs, lib, ... }: 
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/pingu/.config/sops/age/keys.txt";

    secrets = {
      cloudflared.nyx.token = {};
    };
  };
}
