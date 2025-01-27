{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vim
    pciutils
    gitMinimal
    nixos-install-tools
    util-linux
  ];
}
