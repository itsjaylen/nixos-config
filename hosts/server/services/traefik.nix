{ config, pkgs, ... }: {
  # Disable Traefik completely
  services.traefik.enable = false;

  services.nginx = {
    enable = true;

    virtualHosts."git.home" = {
      # Listen on port 80, HTTP only
      listen = [ { addr = "0.0.0.0"; port = 80; } ];

      locations."/" = {
        proxyPass = "http://0.0.0.0:3000";
        # Gitea needs WebSocket support
        proxyWebsockets = true;
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 ];
}