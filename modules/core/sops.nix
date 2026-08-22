{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    sops
    age
  ];

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.keyFile = "/var/lib/sops-nix/key.txt";

    secrets = {
      "github_ssh_key" = {
        owner = "jaylen";
        path = "/home/jaylen/.ssh/id_rsa";
        mode = "0600";
      };
      "gitea_token" = {
        owner = "jaylen";
      };
    };
  };
}