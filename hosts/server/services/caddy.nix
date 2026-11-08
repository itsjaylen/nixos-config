{ config, pkgs, ... }: {
  services.caddy.enable = false;

  systemd.services.caddy = {
    description = "Caddy";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.caddy}/bin/caddy run --config ${pkgs.writeText "Caddyfile" ''
        http://git.home {
          reverse_proxy http://127.0.0.1:3000
        }
      ''}";
      ExecReload = "${pkgs.caddy}/bin/caddy reload --config ${pkgs.writeText "Caddyfile" ''
        http://git.home {
          reverse_proxy http://127.0.0.1:3000
        }
      ''}";
      Restart = "on-failure";
      # Key fixes: don't use DynamicUser, explicitly set HOME
      User = "caddy";
      Group = "caddy";
      Environment = [ "HOME=/var/lib/caddy" ];
      # Ensure port 80 binding permission
      AmbientCapabilities = [ "CAP_NET_BIND_SERVICE" ];
      StateDirectory = "caddy";
    };
  };

  users.users.caddy = { isSystemUser = true; group = "caddy"; };
  users.groups.caddy = {};
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}