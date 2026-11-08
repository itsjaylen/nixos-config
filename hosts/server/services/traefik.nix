{ config, pkgs, ... }: {
  services.caddy = {
    enable = true;

    # Caddy listens on :80 by default; AdGuard's dnsrewrite
    # sends clients to 192.168.50.188:80, so this just works.
    virtualHosts."git.arpa".extraConfig = ''
      reverse_proxy 127.0.0.1:3000
    '';
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}