{
  pkgs,
  inputs,
  ...
}: {
  home = {
    packages = with pkgs; [
      (inputs.quickshell.packages.${pkgs.system}.default.override
        {
          withJemalloc = true;
          withQtSvg = true;
          withWayland = true;
          withX11 = false;
          withPipewire = true;
          withPam = true;
          withHyprland = true;
          withI3 = false;
        })
      swww
      fd
      wl-clipboard
      cliphist
      brightnessctl
      slurp
      pwvucontrol
      libnotify

      kdePackages.full
      kdePackages.qtdeclarative
    ];
  };
}
