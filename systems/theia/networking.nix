{lib, ...}: let
  inherit (lib.modules) mkForce;
in {
  networking = {
    enableIPv6 = true;
    firewall = {
      allowedTCPPorts = [
        80 # HTTP
        443 # HTTPS
        25565 # minecraft
        25566 # minecraft
        25567 # minecraft
      ];
      allowedUDPPorts = [
        25565 # minecraft
        25566 # minecraft
        25567 # minecraft
      ];
    };
    hostName = "theia";
    nameservers = ["1.1.1.1" "8.8.8.8" "9.9.9.9"];
    domain = "blahai.gay";
    useDHCP = mkForce false;
    defaultGateway = {
      address = "178.63.247.183";
      interface = "ens3";
    };
    defaultGateway6 = {
      address = "	2a01:4f8:2201:f900:2::2";
      interface = "ens3";
    };

    interfaces = {
      ens3 = {
        ipv4 = {
          addresses = [
            {
              address = "178.63.118.252";
              prefixLength = 32;
            }
          ];

          routes = [
            {
              address = "178.63.247.183";
              prefixLength = 32;
            }
          ];
        };
        ipv6 = {
          addresses = [
            {
              address = "2a01:4f8:2201:f912::a";
              prefixLength = 64;
            }
          ];

          routes = [
            {
              address = "fe80::1";
              prefixLength = 128;
            }
          ];
        };
      };
    };
  };
}
