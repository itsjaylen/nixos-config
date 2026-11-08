{ config, pkgs, ... }: {
  # Disable the NixOS Caddy module entirely
  services.caddy.enable = false;

  # Run Caddy manually with your own config
  systemd.services.caddy = {
    description = "Caddy (manual)";
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
      DynamicUser = true;
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}