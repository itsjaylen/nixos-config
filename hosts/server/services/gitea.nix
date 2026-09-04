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
        HTTP_ADDR = "127.0.0.1";
        ROOT_URL = "http://localhost:3000/"; # Replace with Cloudflare domain URL
        SSH_PORT = 2222;
      };
      service = {
        DISABLE_REGISTRATION = false;
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 2222 ];
}