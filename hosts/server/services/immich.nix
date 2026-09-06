{ config, pkgs, ... }: {
  services.immich = {
    enable = true;
    host = "0.0.0.0";
    port = 2283;
    mediaLocation = "/var/lib/immich";
    
    database = {
      host = "/run/postgresql";
      name = "immich";
      user = "immich";
    };
  };

  # Point Immich to the shared Redis instance via environment variables
  systemd.services.immich-server.serviceConfig.Environment = [
    "REDIS_HOSTNAME=127.0.0.1"
    "REDIS_PORT=6379"
  ];

  networking.firewall.allowedTCPPorts = [ 2283 ];
}