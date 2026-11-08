{ config, pkgs, ... }: {
  services.caddy = {
    enable = true;
    virtualHosts."git.arpa".extraConfig = ''
      tls internal
      reverse_proxy 127.0.0.1:3000
    '';
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}