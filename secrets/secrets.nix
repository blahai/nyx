let
  pingu = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILPbmiNqoyeKXk/VopFm2cFfEnV4cKCFBhbhyYB69Fuu";
  elissa = "";
  users = [pingu elissa];

  theia = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID3V7BfUmisdxsALpGc6ep2+hanPKKcrg4/es7cza4BA";
  systems = [theia];
in {
  "forgejo-runner-token.age".publicKeys = [theia];
  "vaultwarden-env.age".publicKeys = [theia];
}
