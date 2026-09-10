{ config, pkgs, ... }:

{
  services.clickhouse = {
    enable = true;
    
    # Using just "::" enables IPv6 dual-stack, binding both IPv4 and IPv6 
    # cleanly without duplicating socket attempts on ports like 9009.
    serverConfig = {
      listen_host = "::";
    };

    usersConfig = {
      users.user = {
        profile = "default";
        password_sha256_hex = builtins.hashString "sha256" "SuperSecretPassword";
        networks.ip = [ "127.0.0.1" "::1" ];
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 8123 9000 ];

  systemd.services.rustlog.after = [ "clickhouse.service" ];
  systemd.services.rustlog.requires = [ "clickhouse.service" ];
}