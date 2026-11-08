{ config, pkgs, ... }: {
  # 1. Ensure Caddy is completely disabled
  services.caddy.enable = false;

  # 2. Enable Traefik
  services.traefik = {
    enable = true;

    # Static configuration: listen on port 80, enable API/Dashboard (optional)
    staticConfigOptions = {
      entryPoints.web.address = ":80";

      api = {
        dashboard = true;
        # For debugging, you can temporarily enable insecure dashboard (port 8080)
        # insecure = true;
      };

      log.level = "INFO";
    };

    # Dynamic configuration: define routing rules here
    dynamicConfigOptions = {
      http.routers.git-home = {
        rule = "Host(`git.home`)";
        service = "gitea";
        entryPoints = [ "web" ];
      };

      http.services.gitea.loadBalancer.servers = [
        { url = "http://127.0.0.1:3000"; }
      ];
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}