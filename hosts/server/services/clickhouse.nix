{ config, pkgs, ... }:

{
  services.clickhouse = {
    enable = true;
    
    # Listen on all IPv4 and IPv6 addresses
    serverConfig = {
      listen_host = [ "0.0.0.0" "::" ];
    };

    # Optional: configure databases or users directly via Nix
    usersConfig = {
      users.user = {
        profile = "default";
        password_sha256_hex = builtins.hashString "sha256" "SuperSecretPassword";
        networks.ip = [ "127.0.0.1" "::1" ];
      };
    };
  };

  # Open ClickHouse ports in the firewall (8123 for HTTP, 9000 for native TCP)
  networking.firewall.allowedTCPPorts = [ 8123 9000 ];

  # Ensure rustlog's systemd service waits for ClickHouse to be up and running
  systemd.services.rustlog.after = [ "clickhouse.service" ];
  systemd.services.rustlog.requires = [ "clickhouse.service" ];
}