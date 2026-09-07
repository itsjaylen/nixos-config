{ config, pkgs, ... }: {
  # Hardware & system metric exporter
  services.prometheus.exporters.node = {
    enable = true;
    port = 9100;
    listenAddress = "127.0.0.1"; # Forces IPv4 binding to match your Prometheus scrape target
  };

  # PostgreSQL metric exporter
  services.prometheus.exporters.postgres = {
    enable = true;
    port = 9187;
    dataSourceName = "postgresql:///postgres?host=/run/postgresql&sslmode=disable";
    listenAddress = "127.0.0.1"; # Recommended consistency fix for postgres exporter too
  };

  # Main Prometheus daemon
  services.prometheus = {
    enable = true;
    port = 9090;

    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [
          { targets = [ "127.0.0.1:9100" ]; }
        ];
      }
      {
        job_name = "gitea";
        static_configs = [
          { targets = [ "127.0.0.1:3000" ]; }
        ];
      }
      {
        job_name = "postgres";
        static_configs = [
          { targets = [ "127.0.0.1:9187" ]; }
        ];
      }
    ];
  };

  networking.firewall.allowedTCPPorts = [ 9090 9100 9187 ];
}