{ config, pkgs, ... }: {
  services.adguardhome = {
    enable = true;
    host = "0.0.0.0";
    port = 3005;
    settings = {
      dns = {
        bind_hosts = [ "0.0.0.0" ];
        port = 53;
        upstream_dns = [
          "9.9.9.9#dns.quad9.net"
          "149.112.112.112#dns.quad9.net"
        ];
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 3005 53 ];
  networking.firewall.allowedUDPPorts = [ 53 ];
}