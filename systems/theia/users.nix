{pkgs, ...}: {
  olympus.system = {
    mainUser = "pingu";
  };

  users = {
    users.root = {
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILPbmiNqoyeKXk/VopFm2cFfEnV4cKCFBhbhyYB69Fuu"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILLqPq70t6RbnI8UejEshYcfBP66I4OrLFjvGLLfIEXD"
      ];
    };

    users.pingu = {
      isNormalUser = true;
      extraGroups = ["wheel"];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILPbmiNqoyeKXk/VopFm2cFfEnV4cKCFBhbhyYB69Fuu"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILLqPq70t6RbnI8UejEshYcfBP66I4OrLFjvGLLfIEXD"
      ];
    };

    users.minecraft = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILPbmiNqoyeKXk/VopFm2cFfEnV4cKCFBhbhyYB69Fuu" # nyx
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILLqPq70t6RbnI8UejEshYcfBP66I4OrLFjvGLLfIEXD" # laptop
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDbAlKwToOiUT6zA6qdgETTuJVRFeSjkBJWLzUWLLAtQZnPJ4gWZMxcHbkoPryY6L5DnibmqliLnAw2cjaREJw3BJ8Di0W1UdSZqZZejipjkfBBDLadckkv6WTskShyCtN/Mum8hkBMbGFrWXSM+8MPEj6pS8WgRnrHjDR27tIyUkP+f6n2B7g8z34o26jmKkIC+cLV5D3IhRhVpi49oPqrI59aWWw6ikOSITdLfdIuNxmlgD9cVhWnVohPp2hfoYF5VwIpWYUwL1zkQdiBvCXKT35DqQLy/jKcHegVHk5ZLeaZlaZ7dyiu5xnQUuTgg6m9r1VW+E3XHuRNp33SMhkGs/LVJWtx0fAEzlQDfQQl9SE2k6XXffZYSeOgFO8hYatGrfZ2Dx4yeacFnckitJglyq8SjIn5lUB4UN/48iD6v1thf0LyOy279LKsbmL90nNrRHP7ByFOTwAb1IsGMARAGeMLZfyvaOOSSfRfm0NqCpi1CV9vX5qwG3w34ifirDs=" # slogo laptop
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDAu9nk21JNaOTGBeUw3AOF0uA0ErcMf/2hvjUASXuPcBf9gI7huy0RXPvWO7JiOUorYdqMo9zB792tso4+o0RMYoAKC1A+AP0L1w8uKs4KdhbWsduEZhT3Nmp4OSFhi+Ycv2ZK6MQ52k9OVAbjT2xzyE7GSZHTPFVszr03bpeFkgDE/9K7px6r/KPKrXOn7DMRbgXkyjkOOhB8cCGW8VbJDVwz1/M3p1gfIQDZIcGvt5b6CjcuOyfYPORlcVUdRNVLxdHio4YLjKu6w2M74tVaEvRBb5fl+OTztDyENyEiGo2Pr5xYew5oIuVG4+pZZUpjxOPB+uWr8tPct/kuq/hxqJ5byrsv+bW4CNWlRxKiHC0SLtIlkEXKbCIs0IvEjbFv3tS+wSCU9qdb39yZUXknc09GUmd8ZNfsmPNAg4+1irTfSy7R24Wi76B/dEMyb6TUKm1zUfRRnTCTngr7WZAn/UcPDvwUduJu64h99TRWOtU9T2ih33xkfk3zCJpME5s=" # slogo desktop
      ];
      packages = with pkgs; [
        openjdk21
        openjdk17
        screen
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    git
    curl
    bat
    neovim
    btop
    zip
    jq
    busybox
    fish
    ethtool
    networkd-dispatcher
  ];
}
