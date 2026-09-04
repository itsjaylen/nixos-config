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
    };
  };

  # Allow HTTP and SSH ports for Gitea
  networking.firewall.allowedTCPPorts = [ 3000 2222 ];
}