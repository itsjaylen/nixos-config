{ config, pkgs, ... }:

{
  services.clickhouse = {
    enable = true;

    serverConfig = {
      listen_host = "::";
    };

    # Do NOT use usersConfig or extraUsersConfig here.
    # We inject the rustlog user via /etc/clickhouse-server/users.d/ below.
  };

  # Render the users.xml fragment with the hashed password from sops.
  sops.templates."clickhouse-users.xml" = {
    content = ''
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
    # Leave owner/group/mode off — the file lives under /run/secrets-rendered
    # and gets symlinked into /etc by environment.etc below.
  };

  # ClickHouse loads every *.xml under users.d/ at startup.
  environment.etc."clickhouse-server/users.d/rustlog.xml".source =
    config.sops.templates."clickhouse-users.xml".path;

  networking.firewall.allowedTCPPorts = [ 8123 9000 ];

  systemd.services.rustlog.after = [ "clickhouse.service" ];
  systemd.services.rustlog.requires = [ "clickhouse.service" ];
}