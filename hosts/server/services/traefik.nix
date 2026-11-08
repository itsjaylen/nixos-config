{ config, pkgs, ... }: {
  services.traefik = {
    enable = true;

    staticConfigOptions = {
      entryPoints = {
        web.address = ":80";
        # Change a port that is definitely unoccupied for the dashboard
        traefik.address = ":28080";
      };
      api = {
        dashboard = true;
        insecure = true;  # Will use the traefik entryPoint above, i.e., port 9090
      };
      log.level = "DEBUG";
      providers.file = {
        filename = "/etc/traefik/dynamic_config.toml";
        watch = true;
      };
    };
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

  networking.firewall.allowedTCPPorts = [ 80 9090 ];
}