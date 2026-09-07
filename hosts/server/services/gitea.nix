{ config, pkgs, ... }: {
  services.gitea = {
    enable = true;
    appName = "Gitea";

    database = {
      type = "postgres";
      user = "gitea";
      name = "gitea";
      host = "/run/postgresql";
    };

    settings = {
      server = {
        HTTP_PORT = 3000;
        HTTP_ADDR = "0.0.0.0";
        ROOT_URL = "http://localhost:3000/";
        SSH_PORT = 2222;
      };
      service = {
        DISABLE_REGISTRATION = false;
      };
      metrics = {
        ENABLED = true;
      };
      actions = {
        ENABLED = true;
      };
    };
  };

  # Local Gitea Actions Runner linked to the sops-nix secret
  services.gitea-actions-runner.instances.default = {
      enable = true;
      name = "nix-server-runner";
      url = "http://localhost:3000/";
      tokenFile = config.sops.secrets.gitea_runner_token.path;
      labels = [
        "ubuntu-latest:host"
      ];
      hostPackages = with pkgs; [
        git
        nix
        cacert
        nixos-rebuild
        nodejs
        bash
        inetutils
      ];
    };

  # Allow HTTP and SSH ports for Gitea
  networking.firewall.allowedTCPPorts = [ 3000 2222 ];
}