{ config, pkgs, ... }: {
  services.traefik = {
    enable = true;

    staticConfigOptions = {
      entryPoints.web.address = ":80";
      api.dashboard = true;
      api.insecure = true;
      log.level = "DEBUG";
      # Do not write providers.file here, let dynamicConfigFile handle it
    };

    # Key: tell the NixOS module to read the dynamic config from this path
    dynamicConfigFile = "/etc/traefik/dynamic_config.toml";
  };

  # Write the TOML file to /etc instead of the Nix store
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

  networking.firewall.allowedTCPPorts = [ 80 8080 ];
}