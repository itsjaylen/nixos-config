{ config, pkgs, ... }: {
  services.caddy = {
    enable = true;
    configFile = pkgs.writeText "Caddyfile" ''
      http://git.home {
        reverse_proxy http://127.0.0.1:3000
      }
    '';
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}