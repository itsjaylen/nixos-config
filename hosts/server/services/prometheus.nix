{ config, pkgs, ... }: {
  # Hardware & system metric exporter (using default collectors)
  services.prometheus.exporters.node = {
    enable = true;
    port = 9100;
  };

  # PostgreSQL metric exporter
  services.prometheus.exporters.postgres = {
    enable = true;
    port = 9187;
    dataSourceName = "postgresql:///postgres?host=/run/postgresql&sslmode=disable";
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