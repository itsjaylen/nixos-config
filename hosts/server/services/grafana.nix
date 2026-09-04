{ config, pkgs, ... }: {
  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "0.0.0.0";
        http_port = 3001;
        domain = "localhost";
      };
      security = {
        admin_user = "admin";
        # Pull admin password safely from SOPS
        admin_password = "$__file{${config.sops.secrets."grafana_admin_password".path}}";
      };
    };

    # Declaratively attach Prometheus as the default data source
    provision = {
      enable = true;
      datasources.settings.datasources = [
        {
          name = "Prometheus";
          type = "prometheus";
          access = "proxy";
          url = "http://127.0.0.1:9090";
          isDefault = true;
        }
      ];
    };
  };

  networking.firewall.allowedTCPPorts = [ 3001 ];
}