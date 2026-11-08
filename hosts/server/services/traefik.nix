{ config, pkgs, ... }: {
  # Disable Traefik completely
  services.traefik.enable = false;

  services.nginx = {
    enable = true;
    validateConfigFile = false;

    virtualHosts."git.home" = {
      # Listen on port 80, HTTP only
      listen = [ { addr = "0.0.0.0"; port = 80; } ];

      locations."/" = {
        proxyPass = "http://127.0.0.1:3000";
        extraConfig = ''
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
        '';
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 ];
}