{ config, pkgs, ... }: {
  sops.secrets.cloudflare-env = {
    # Put TUNNEL_TOKEN=ey... inside secrets.yaml under key cloudflare-env
    mode = "0400";
  };

  services.cloudflared = {
    enable = true;
    tunnels = {
      "server-tunnel" = {
        default = "http_status:404";
      };
    };
  };

  systemd.services."cloudflared-tunnel-server-tunnel".serviceConfig = {
    EnvironmentFile = config.sops.secrets.cloudflare-env.path;
  };
}