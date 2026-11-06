{ ... }:

{
  # Node exporter so your existing grafana/prometheus can scrape this box.
  services.prometheus.exporters.node = {
    enable = true;
    port = 9100;
    enabledCollectors = [ "systemd" "processes" ];
  };

  networking.firewall.allowedTCPPorts = [ 9100 ];
}