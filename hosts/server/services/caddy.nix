{ config, pkgs, ... }: {
  services.caddy = {
    enable = true;

    # Don't try to obtain public certs for local-only names
    globalConfig = ''
      auto_https off
    '';

    virtualHosts."git.home".extraConfig = ''
      reverse_proxy http://127.0.0.1:3000
    '';
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}