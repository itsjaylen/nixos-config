{ config, pkgs, ... }: {
  services.caddy = {
    enable = true;
  
    virtualHosts.":80" = {
      extraConfig = ''
        bind 0.0.0.0
        reverse_proxy 127.0.0.1:3000
      '';
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}