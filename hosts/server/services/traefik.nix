{ config, pkgs, ... }: {
  services.caddy = {
    enable = true;
    extraConfig = ''
      :80 {
        reverse_proxy 127.0.0.1:3000
      }
    '';
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}