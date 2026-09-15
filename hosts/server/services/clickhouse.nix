{ config, pkgs, ... }:

{
  services.clickhouse = {
    enable = true;

    serverConfig = {
      listen_host = "::";

      # Tell ClickHouse to also load user fragments from a runtime dir
      user_directories = {
        users_xml = {
          path = "/run/clickhouse-users.d";
        };
      };
    };
  };

  # The clickhouse user owns this runtime dir. Written at boot.
  systemd.tmpfiles.rules = [
    "d /run/clickhouse-users.d 0750 clickhouse clickhouse -"
  ];

  # Write the rustlog fragment before ClickHouse starts.
  # Runs as root (systemd.tmpfiles + ExecStartPre with User=root override).
  systemd.services.clickhouse.preStart = ''
    cat > /run/clickhouse-users.d/rustlog.xml <<EOF
    <clickhouse>
      <users>
        <rustlog>
          <password_sha256_hex>$(cat /run/secrets/clickhouse_user_password_sha256)</password_sha256_hex>
          <networks>
            <ip>127.0.0.1</ip>
            <ip>::1</ip>
          </networks>
          <profile>default</profile>
          <quota>default</quota>
        </rustlog>
      </users>
    </clickhouse>
    EOF
    chown clickhouse:clickhouse /run/clickhouse-users.d/rustlog.xml
    chmod 0400 /run/clickhouse-users.d/rustlog.xml
  '';

  # Make sure preStart runs as root, not as the clickhouse user
  systemd.services.clickhouse.serviceConfig = {
    PermissionsStartOnly = true;
  };

  networking.firewall.allowedTCPPorts = [ 8123 9000 ];

  systemd.services.rustlog.after = [ "clickhouse.service" ];
  systemd.services.rustlog.requires = [ "clickhouse.service" ];
}