{ config, pkgs, ... }:

{
  services.clickhouse = {
    enable = true;
    serverConfig = {
      listen_host = "::";
    };
  };

  systemd.services.clickhouse.serviceConfig = {
    ExecStartPre = [
      "+${pkgs.writeShellScript "clickhouse-write-config" ''
        mkdir -p /etc/clickhouse-server/config.d /etc/clickhouse-server/users.d

        # Drop-in Prometheus endpoint config — overrides the commented-out
        # <prometheus> block in the main config.xml.
        cat > /etc/clickhouse-server/config.d/prometheus.xml <<EOF
        <clickhouse>
          <prometheus>
            <endpoint>/metrics</endpoint>
            <port>9363</port>
            <metrics>true</metrics>
            <events>true</events>
            <asynchronous_metrics>true</asynchronous_metrics>
            <status_info>true</status_info>
          </prometheus>
        </clickhouse>
        EOF

        # rustlog user fragment
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

        chown clickhouse:clickhouse \
          /etc/clickhouse-server/config.d/prometheus.xml \
          /etc/clickhouse-server/users.d/rustlog.xml
        chmod 0400 \
          /etc/clickhouse-server/config.d/prometheus.xml \
          /etc/clickhouse-server/users.d/rustlog.xml
      ''}"
    ];
  };

  networking.firewall.allowedTCPPorts = [ 8123 9000 9363 ];

  systemd.services.rustlog.after = [ "clickhouse.service" ];
  systemd.services.rustlog.requires = [ "clickhouse.service" ];
}