{ config, pkgs, ... }: {
  # Disable Traefik completely
  services.traefik.enable = false;

  services.nginx = {
    enable = true;
    validateConfigFile = false;
    # Do not use virtualHosts, write the raw configuration directly
    appendHttpConfig = ''
      server {
        listen 80;
        server_name git.home;
  
        location / {
          proxy_pass http://127.0.0.1:3000;
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
        }
      }
    '';
  };

  networking.firewall.allowedTCPPorts = [ 80 ];
}