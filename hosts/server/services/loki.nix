{ config, pkgs, ... }: {
  services.loki = {
    enable = true;
    configuration = {
      server.http_port = 3100;
      auth_enabled = false;
      common = {
        path_prefix = "/var/lib/loki";
        storage.filesystem = {
          chunks_directory = "/var/lib/loki/chunks";
          rules_directory = "/var/lib/loki/rules";
        };
        replication_factor = 1;
        ring.kvstore.store = "inmemory";
      };
      schema_config.configs = [{
        from = "2024-01-01";
        store = "boltdb-shipper";
        object_store = "filesystem";
        schema = "v11";
      }];
      analytics.reporting_enabled = false;
    };
  };

  # Modern replacement for Promtail
  services.alloy = {
    enable = true;
    extraFlags = [ ];
    config = ''
      loki.relabel "journal" {
        rule {
          source_labels = ["__journal__systemd_unit"]
          target_label  = "unit"
        }
      }

      discovery.relabel "journal" {
        targets = []

        rule {
          source_labels = ["__journal__systemd_unit"]
          target_label  = "unit"
        }
      }

      lokirewrite "journal" {
        endpoint {
          url = "http://127.0.0.1:3100/loki/api/v1/push"
        }
      }

      loki.source.journal "journal" {
        max_age   = "12h"
        path      = "/var/log/journal"
        relabel_rules = loki.relabel.journal.rules
        forward_to = [loki.write.endpoint.receiver]
      }

      loki.write "endpoint" {
        endpoint {
          url = "http://127.0.0.1:3100/loki/api/v1/push"
        }
      }
    '';
  };

  networking.firewall.allowedTCPPorts = [ 3100 ];
}