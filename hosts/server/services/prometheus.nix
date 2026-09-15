{ config, pkgs, ... }: {
  # Hardware & system metric exporter
  services.prometheus.exporters.node = {
    enable = true;
    port = 9100;
    listenAddress = "127.0.0.1";
  };

  # PostgreSQL metric exporter
  services.prometheus.exporters.postgres = {
    enable = true;
    port = 9187;
    listenAddress = "127.0.0.1";
    environmentFile = config.sops.secrets."postgres_exporter_env".path;
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

  networking.firewall.allowedTCPPorts = [ 9090 9100 9187 30090 ];
}