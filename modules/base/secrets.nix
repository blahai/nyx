{
  config,
  inputs,
  ...
}: let
  inherit (config.olympus.system) mainUser;
  #homeDir = config.home-manager.users.${mainUser}.home.homeDirectory;
  homeDir = config.hjem.users.${mainUser}.directory;
  sshDir = homeDir + "/.ssh";
in {
  imports = [inputs.agenix.nixosModules.default];
  age = {
    # check the main users ssh key and the system key to see if it is safe
    # to decrypt the secrets
    identityPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
      "${sshDir}/id_ed25519"
    ];
  };
}
