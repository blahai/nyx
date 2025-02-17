{pkgs, ...}: {
  services = {
    jellyfin = {
      enable = true;
      openFirewall = true;
      dataDir = "/mnt/zootfs/Media/jellyfin";
      package = pkgs.jellyfin;
      user = "jellyfin";
      group = "jellyfin";
    };

    jellyseerr = {
      enable = true;
      port = 5055;
      openFirewall = true;
      package = pkgs.jellyseerr.overrideAttrs (_: {
        # https://github.com/NixOS/nixpkgs/pull/380532
        postBuild = ''
          # Clean up broken symlinks left behind by `pnpm prune`
          find node_modules -xtype l -delete
        '';
      });
    };

    sonarr = {
      enable = true;
      openFirewall = true;
      dataDir = "/mnt/zootfs/Media/sonarr";
      package = pkgs.sonarr;
      user = "jellyfin";
      group = "jellyfin";
    };

    radarr = {
      enable = true;
      openFirewall = true;
      dataDir = "/mnt/zootfs/Media/radarr";
      package = pkgs.radarr;
      user = "jellyfin";
      group = "jellyfin";
    };

    bazarr = {
      enable = true;
      openFirewall = true;
      package = pkgs.bazarr;
      user = "jellyfin";
      group = "jellyfin";
    };

    prowlarr = {
      enable = true;
      openFirewall = true;
      package = pkgs.prowlarr;
    };
  };
}
