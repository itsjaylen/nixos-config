{ ... }: {
  # Hardware & system metric exporter
  services.prometheus.exporters.node = {
    enable = true;
    enabledCollectors = [ "systemd" "diskstats" "filesystem" "meminfo" "netdev" ];
    port = 9100;
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
    ];
  };

  networking.firewall.allowedTCPPorts = [ 9090 9100 ];
}