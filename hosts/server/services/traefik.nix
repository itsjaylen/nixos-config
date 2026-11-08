{ config, pkgs, ... }: {
  # Disable Traefik completely
  services.traefik.enable = false;

  services.nginx = {
    enable = true;
    validateConfig = false;

    virtualHosts."git.home" = {
      # Listen on port 80, HTTP only
      listen = [ { addr = "0.0.0.0"; port = 80; } ];

      locations."/" = {
        proxyPass = "http://127.0.0.1:3000";
        proxyWebsockets = true;
        extraConfig = ''
          proxy_set_header Host $http_host;
          proxy_set_header X-Forwarded-Proto $scheme;
          proxy_set_header X-Real-IP $remote_addr;
        '';
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 ];
}