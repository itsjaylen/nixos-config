{ config, pkgs, ... }: {
  services.traefik = {
    enable = true;
    staticConfigOptions = {
      entryPoints = {
        web.address = ":80";
        traefik.address = ":28080";
      };
      api = { dashboard = true; insecure = true; };
      log.level = "DEBUG";
      accessLog = {};
      # Explicitly point the file provider to the file in /etc
      providers.file.filename = "/etc/traefik/dynamic_config.toml";
    };
    # Do not use dynamicConfigFile here, let providers.file handle it
  };
  
  environment.etc."traefik/dynamic_config.toml" = {
    user = config.systemd.services.traefik.serviceConfig.User;
    group = config.systemd.services.traefik.serviceConfig.Group;
    mode = "400";
    text = ''
      [http.routers.git-home]
        rule = "PathPrefix(`/`)"
        service = "gitea"
        entryPoints = ["web"]
  
      [http.services.gitea.loadBalancer]
        [[http.services.gitea.loadBalancer.servers]]
          url = "http://127.0.0.1:3000"
    '';
  };

  networking.firewall.allowedTCPPorts = [ 80 28080 ];
}