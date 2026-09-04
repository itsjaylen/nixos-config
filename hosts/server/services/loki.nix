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

  services.promtail = {
    enable = true;
    configuration = {
      server = {
        http_port = 3032;
        grpc_port = 0;
      };
      clients = [{ url = "http://127.0.0.1:3100/loki/api/v1/push"; }];
      scrape_configs = [{
        job_name = "journal";
        journal = {
          max_age = "12h";
          path = "/var/log/journal";
          labels = { job = "systemd-journal"; };
        };
        relabel_configs = [{
          source_labels = [ "__journal__systemd_unit" ];
          target_label = "unit";
        }];
      }];
    };
  };

  networking.firewall.allowedTCPPorts = [ 3100 ];
}