{ config, pkgs, ... }: {
  sops.secrets.cloudflare-env = {
    owner = "cloudflared";
    group = "cloudflared";
    mode = "0400";
  };

  users.users.cloudflared = {
    group = "cloudflared";
    isSystemUser = true;
  };
  users.groups.cloudflared = {};

  systemd.services.cloudflared-tunnel = {
    description = "Cloudflare Tunnel Daemon";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      # Reads $TUNNEL_TOKEN from EnvironmentFile and passes it to the run command
      ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --token \"$TUNNEL_TOKEN\"'";
      EnvironmentFile = config.sops.secrets.cloudflare-env.path;
      Restart = "always";
      RestartSec = "5s";
      User = "cloudflared";
      Group = "cloudflared";
    };
  };
}