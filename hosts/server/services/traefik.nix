{ config, pkgs, ... }: {
  services.caddy = {
    enable = true;
  
    virtualHosts."http://git.arpa".extraConfig = ''
      reverse_proxy 127.0.0.1:3000
    '';
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}