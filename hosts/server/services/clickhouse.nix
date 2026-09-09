{ config, pkgs, ... }:

{
  services.clickhouse = {
    enable = true;
    
    # Optional: configure databases or users directly via Nix
    usersConfig = {
      users.user = {
        profile = "default";
        password_sha256_hex = builtins.hashString "sha256" "SuperSecretPassword";
        networks.ip = [ "127.0.0.1" "::1" ];
      };
    };
  };

  # Ensure rustlog's systemd service waits for ClickHouse to be up and running
  systemd.services.rustlog.after = [ "clickhouse.service" ];
  systemd.services.rustlog.requires = [ "clickhouse.service" ];
}