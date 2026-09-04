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

  # Pass decrypted environment file containing GF_SECURITY_SECRET_KEY to systemd
  systemd.services.grafana.serviceConfig.EnvironmentFile = config.sops.templates."grafana-env".path;

  sops.templates."grafana-env" = {
    content = ''
      GF_SECURITY_SECRET_KEY=${config.sops.placeholder.grafana_secret_key}
    '';
    owner = "grafana";
  };

  networking.firewall.allowedTCPPorts = [ 3001 ];
}