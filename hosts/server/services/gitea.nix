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
        HTTP_PORT  = 3000;
        HTTP_ADDR  = "0.0.0.0";      # ← MUST be 0.0.0.0, not 127.0.0.1
        ROOT_URL   = "http://git.arpa/";
        SSH_PORT   = 2222;
        SSH_DOMAIN = "git.arpa";
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

  networking.firewall.allowedTCPPorts = [ 3000 2222 ];
}