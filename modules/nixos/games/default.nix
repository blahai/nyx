{ config, pkgs, inputs, ... }: {

  nixpkgs = {
    overlays = [
      inputs.nur.overlay
    ];
    config = {
      allowUnfree = true;
    };
  };

  environment.systemPackages = with pkgs; [
    protonup-qt
    prismlauncher
    osu-lazer-bin
    davinci-resolve
    nur.repos.reedrw.jkps
  ];

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
    gamemode.enable = true;
    alvr = {
      enable = true;
      package = pkgs.alvr;
      openFirewall = true;
    };

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [ 
        obs-pipewire-audio-capture
        obs-vaapi
      ];
    };
  };

  hardware = {
    amdgpu.opencl.enable = true; # For davinci-resolve
    opentabletdriver.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [ 
        mesa.drivers
        egl-wayland
        rocmPackages.clr.icd
        amdvlk
        libva
        libva-utils
      ];
    };
  };
}
