{ config, pkgs, ... }:

{
  services.clickhouse = {
    enable = true;

    serverConfig = {
      listen_host = "::";
    };

    # We're no longer using usersConfig for the password.
    # If you had other users defined there, keep only those.
    # The default 'default' user will still exist; we just won't use it.

    # Tell ClickHouse to load our sops-rendered users file.
    extraUsersConfig = ''
      <clickhouse>
        <users>
          <rustlog>
            <password_sha256_hex>${config.sops.placeholder.clickhouse_user_password_sha256}</password_sha256_hex>
            <networks>
              <ip>127.0.0.1</ip>
              <ip>::1</ip>
            </networks>
            <profile>default</profile>
            <quota>default</quota>
          </rustlog>
        </users>
      </clickhouse>
    '';
  };

  # Render the users.xml fragment with the hashed password from sops.
  sops.templates."clickhouse-users.xml" = {
    content = ''
      <clickhouse>
        <users>
          <rustlog>
            <password_sha256_hex>${config.sops.placeholder.clickhouse_rustlog_password_sha256}</password_sha256_hex>
            <networks>
              <ip>127.0.0.1</ip>
              <ip>::1</ip>
            </networks>
            <profile>default</profile>
            <quota>default</quota>
          </rustlog>
        </users>
      </clickhouse>
    '';
    owner = "clickhouse";
    group = "clickhouse";
    mode = "0400";
  };

  networking.firewall.allowedTCPPorts = [ 8123 9000 ];

  # Ensure ClickHouse starts after sops has rendered the config
  systemd.services.clickhouse = {
    after = [ "sops-install-secrets.service" ];
    requires = [ "sops-install-secrets.service" ];
  };

  systemd.services.rustlog.after = [ "clickhouse.service" ];
  systemd.services.rustlog.requires = [ "clickhouse.service" ];
}