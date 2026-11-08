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

      # Key: explicitly enable the file provider and point to the /etc path
      providers.file = {
        filename = "/etc/traefik/dynamic_config.toml";
        watch = true;
      };
    };

    # Do not use dynamicConfigOptions, nor dynamicConfigFile (let providers.file handle it)
  };

  # Write the dynamic configuration to /etc
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