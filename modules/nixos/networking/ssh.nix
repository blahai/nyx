{...}: {
  services.openssh = {
    enable = true;
    startWhenNeeded = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;

      ClientAliveCountMax = 5;
      ClientAliveInterval = 60;
    };
    openFirewall = true;
    ports = [22];
  };
}
