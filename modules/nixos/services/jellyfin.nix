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
      package = pkgs.jellyseerr;
    };

    sonarr = {
      enable = true;
      openFirewall = true;
      dataDir = "/mnt/zootfs/Media/sonarr";
      package = pkgs.sonarr;
      user = "jellyfin";
      group = "jellyfin";
    };

    prowlarr = {
      enable = true;
      openFirewall = true;
      package = pkgs.prowlarr;
    };
  };
  # This bullshittery is cuz sonarr v4 still uses
  # dotnet 6 which is LTS and is marked broken in
  # nixpkgs but they are moving to 8 in v5 which
  # will happen eventually (not anytime soon?)
  nixpkgs.config.permittedInsecurePackages = [
    "aspnetcore-runtime-6.0.36"
    "aspnetcore-runtime-wrapped-6.0.36"
    "dotnet-sdk-6.0.428"
    "dotnet-sdk-wrapped-6.0.428"
  ];
}
