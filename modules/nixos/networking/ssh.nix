{...}: {
  services.openssh = {
    enable = true;
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
