{ config, pkgs, ... }: {
  services.grafana = {
    enable = true;

    # Secret file containing environment variables for Grafana
    secretFile = config.sops.templates."grafana-env".path;

    settings = {
      server = {
        http_addr = "0.0.0.0";
        http_port = 3001;
        domain = "localhost";
      };
      security = {
        admin_user = "admin";
        admin_password = "$__file{${config.sops.secrets."grafana_admin_password".path}}";
      };
    };

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

  # Generate environment variable file for Grafana systemd service
  sops.templates."grafana-env" = {
    content = ''
      GF_SECURITY_SECRET_KEY=${config.sops.placeholder.grafana_secret_key}
    '';
    owner = "grafana";
  };

  networking.firewall.allowedTCPPorts = [ 3001 ];
}