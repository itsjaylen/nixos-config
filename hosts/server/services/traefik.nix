{ config, pkgs, ... }: {
  services.traefik = {
    enable = true;

    staticConfigOptions = {
      entryPoints.web.address = ":80";
      api.dashboard = true;
      api.insecure = true;
      log.level = "DEBUG";

      # Key: enable the file provider and point to the file in /etc
      providers.file = {
        filename = "/etc/traefik/dynamic.toml";
        watch = true;
      };
    };

    # Do NOT use dynamicConfigOptions anymore, let the file provider take over
  };

  # Write the dynamic config to /etc, avoiding the Nix store path change issue
  environment.etc."traefik/dynamic.toml" = {
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

  networking.firewall.allowedTCPPorts = [ 80 8080 ];
}