{ config, pkgs, ... }: {
  services.caddy = {
    enable = true;

    virtualHosts."git.home".extraConfig = ''
      reverse_proxy http://127.0.0.1:3000
    '';
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}