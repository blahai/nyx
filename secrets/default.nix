let
  pingu = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILPbmiNqoyeKXk/VopFm2cFfEnV4cKCFBhbhyYB69Fuu";
  elissa = "";
  users = [pingu elissa];
in {
  "forgejo-runner-token.age".publicKeys = [pingu];
}
