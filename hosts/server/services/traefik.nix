{ config, pkgs, ... }: {
  services.caddy = {
    enable = true;
  
    virtualHosts."*:80" = {
      extraConfig = ''
        reverse_proxy 127.0.0.1:3000
      '';
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}