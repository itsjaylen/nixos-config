{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    sops
    age
    ssh-to-age
  ];

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    # Tells sops-nix to use the host's SSH ed25519 key for decryption
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    # Automatically creates /var/lib/sops-nix/key.txt on boot if it does not exist
    age.generateKey = true;

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
      "garage_rpc_secret" = { };
      "garage_s3_access_key" = { };
      "garage_s3_secret_key" = { };
      "restic_password" = { };
    };
  };

  system.activationScripts.ensureSshDir = ''
    install -d -m 700 -o jaylen -g users /home/jaylen/.ssh
  '';
}