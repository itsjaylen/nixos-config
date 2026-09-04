{ config, pkgs, ... }:

{
  sops.secrets = {
    "grafana_admin_password" = {
      owner = "grafana";
    };
    "grafana_secret_key" = {
      owner = "grafana";
    };
  };

  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "0.0.0.0";
        http_port = 3001;
        serve_from_sub_path = false;
      };
      security = {
        admin_password = "$__file{${config.sops.secrets."grafana_admin_password".path}}";
        secret_key = "$__file{${config.sops.secrets."grafana_secret_key".path}}";
        cookie_secure = false;
      };
      "auth.anonymous" = {
        enabled = true;
        org_role = "Viewer";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 3001 ];
}