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
      ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run";
      EnvironmentFile = config.sops.secrets.cloudflare-env.path;
      Restart = "always";
      User = "cloudflared";
      Group = "cloudflared";
    };
  };
}