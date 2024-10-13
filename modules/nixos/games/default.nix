{ config, pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    protonup-qt
    prismlauncher
    osu-lazer-bin
    obs-studio
    davinci-resolve
  ];

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
    gamemode.enable = true;
  };

  hardware = {
    amdgpu.opencl.enable = true; # For davinci-resolve
    opentabletdriver.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
