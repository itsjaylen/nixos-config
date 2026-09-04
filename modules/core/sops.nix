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
        group = "users";
        path = "/home/jaylen/.ssh/id_ed25519";
        mode = "0600";
      };
      "gitea_token" = {
        owner = "jaylen";
        group = "users";
      };
    };
  };

  system.activationScripts.ensureSshDir = ''
    install -d -m 700 -o jaylen -g users /home/jaylen/.ssh
  '';
}