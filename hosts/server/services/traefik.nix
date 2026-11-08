{ config, pkgs, ... }: {
  services.traefik = {
    enable = true;

    staticConfigOptions = {
      entryPoints = {
        web.address = ":80";
        traefik.address = ":28080";
      };
      api = {
        dashboard = true;
        insecure = true;
      };
      log.level = "DEBUG";
    };

    # Key: point to a path in /etc (string, not Nix store path)
    dynamicConfigFile = "/etc/traefik/dynamic_config.toml";
  };

  environment.etc."traefik/dynamic_config.toml" = {
    text = ''
      [http.routers.git-home]
        rule = "Host(`git.home`)"
        service = "gitea"
        entryPoints = ["web"]

      [http.services.gitea.loadBalancer]
        [[http.services.gitea.loadBalancer.servers]]
          url = "http://127.0.0.1:3000"
    '';
    mode = "400";
  };

  networking.firewall.allowedTCPPorts = [ 80 28080 ];
}