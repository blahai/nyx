{ pkgs, config, ... }: {
  hardware.bluetooth = {
    enable = true;
    settings = { General = { Experimental = true; }; };
  };
  services.blueman.enable = true;
}
