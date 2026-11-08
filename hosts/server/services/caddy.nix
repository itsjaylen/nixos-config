{ config, pkgs, ... }: {
  services.caddy = {
    enable = true;

    # Global config: allow HTTP (80) and HTTPS (443) locally, and define a reusable snippet for TLS
    globalConfig = ''
      # For internal local domains, use Caddy's internal CA to issue certificates
      local_certs
    '';

    virtualHosts."git.home".extraConfig = ''
      # Use internal CA for TLS (browsers will show a warning until you trust Caddy's root CA)
      tls internal
      # Reverse proxy to Gitea's actual port
      reverse_proxy http://127.0.0.1:3000
    '';
  };

  # Open HTTP/HTTPS ports
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}