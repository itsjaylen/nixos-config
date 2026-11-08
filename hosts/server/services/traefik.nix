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
      # Wiki example: enable watch
    };

    # Key: use string, not path
    dynamicConfigFile = "/etc/traefik/dynamic_config.toml";
  };

  environment.etc."traefik/dynamic_config.toml" = {
    # Wiki example: directly reference the service's user/group
    user = config.systemd.services.traefik.serviceConfig.User;
    group = config.systemd.services.traefik.serviceConfig.Group;
    mode = "400";
    text = ''
      [http.routers.git-home]
        rule = "Host(`git.home`)"
        service = "gitea"
        entryPoints = ["web"]

      [http.services.gitea.loadBalancer]
        [[http.services.gitea.loadBalancer.servers]]
          url = "http://127.0.0.1:3000"
    '';
  };

  networking.firewall.allowedTCPPorts = [ 80 28080 ];
}