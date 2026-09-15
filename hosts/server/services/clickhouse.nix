{ config, pkgs, ... }:

{
  services.clickhouse = {
    enable = true;

    serverConfig = {
      listen_host = "::";
    };
  };

  # Write the rustlog user fragment into ClickHouse's users.d/ directory
  # before the server starts, reading the hash from the sops secret file.
  systemd.services.clickhouse.preStart = ''
    mkdir -p /etc/clickhouse-server/users.d
    cat > /etc/clickhouse-server/users.d/rustlog.xml <<EOF
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
    chown clickhouse:clickhouse /etc/clickhouse-server/users.d/rustlog.xml
    chmod 0400 /etc/clickhouse-server/users.d/rustlog.xml
  '';

  networking.firewall.allowedTCPPorts = [ 8123 9000 ];

  systemd.services.rustlog.after = [ "clickhouse.service" ];
  systemd.services.rustlog.requires = [ "clickhouse.service" ];
}