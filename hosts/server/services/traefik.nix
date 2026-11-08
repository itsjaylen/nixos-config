{ config, pkgs, ... }: {
  services.caddy = {
    enable = true;
    extraConfig = ''
      :18080 {
        reverse_proxy 127.0.0.1:3000
      }
    '';
  };
  
  networking.firewall.allowedTCPPorts = [ 18080 ];
}