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

      # Add this line to ensure file changes are watched
      providers.file.watch = true;
    };

    # Key: point to the /etc path
    dynamicConfigFile = "/etc/traefik/dynamic_config.toml";
  };

  environment.etc."traefik/dynamic_config.toml" = {
    user = "traefik";   # Use fixed username/group name
    group = "traefik";
    mode = "444";       # Allow everyone to read, avoid permission issues
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