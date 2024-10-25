{ lib, config, pkgs, inputs, ... }: 
{
  imports = [
    ../../../secrets/secrets.nix 
  ];

  users.users.cloudflared = {
    group = "cloudflared";
    isSystemUser = true;
  };
  users.groups.cloudflared = { };

  systemd.services.my_tunnel = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" "systemd-resolved.service" ];
    serviceConfig = {
      ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --token=${sops.secrets.cloudflared.nyx.token}";
      Restart = "always";
      User = "cloudflared";
      Group = "cloudflared";
    };
  };

}