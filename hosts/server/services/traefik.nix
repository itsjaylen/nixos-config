{ config, pkgs, ... }: {
  # Disable Traefik completely
  services.traefik.enable = false;

  services.nginx = {
    enable = true;

    virtualHosts."git.home" = {
      # Listen on port 80, HTTP only
      listen = [ { addr = "0.0.0.0"; port = 80; } ];

      locations."/" = {
        proxyPass = "http://127.0.0.1:3000";
        proxyWebsockets = true;
        extraConfig = ''
          proxy_set_header Host $host;
        '';
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 ];
}