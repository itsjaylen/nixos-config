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
      app_mode = "production";
      server = {
        http_addr = "0.0.0.0";
        http_port = 3001;
        domain = "192.168.50.188";
        root_url = "%(protocol)s://%(domain)s:%(http_port)s/";
        serve_from_sub_path = false;
        enforce_domain = false;
      };
      security = {
        admin_password = "$__file{${config.sops.secrets."grafana_admin_password".path}}";
        secret_key = "$__file{${config.sops.secrets."grafana_secret_key".path}}";
        cookie_secure = false;
        cookie_samesite = "lax";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 3001 ];
}