{ config, pkgs, ... }: {
  services.gitea = {
    enable = true;
    appName = "Gitea";
    lfs.enable = true;

    database = {
      type = "postgres";
      user = "gitea";
      name = "gitea";
      host = "/run/postgresql";
    };

    settings = {
      server = {
        HTTP_PORT = 3000;
        HTTP_ADDR = "127.0.0.1";          # only Caddy talks to it
        ROOT_URL  = "http://git.arpa/";   # must match what users type
        SSH_PORT  = 2222;
        SSH_DOMAIN = "git.arpa";          # so clone URLs say git.arpa:2222
      };
      service.DISABLE_REGISTRATION = false;
      metrics.ENABLED = true;
      actions.ENABLED = true;
    };
  };

  services.gitea-actions-runner.instances.default = {
    enable = true;
    name = "nix-server-runner";
    url = "http://127.0.0.1:3000/";
    tokenFile = config.sops.secrets.gitea_runner_token.path;
    labels = [ "ubuntu-latest:host" ];
    hostPackages = with pkgs; [ git nix cacert nixos-rebuild ];
  };

  # 3000 is now loopback-only; don't open it in the firewall.
  networking.firewall.allowedTCPPorts = [ 2222 ];
}