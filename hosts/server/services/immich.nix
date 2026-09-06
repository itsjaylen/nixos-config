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

    # Explicitly use your shared redis-main instance instead of spawning a second one
    redis.enable = false; # Let it fallback or point manually if needed, or use localhost TCP since redis-main owns 6379
  };

  # If Immich's module expects a local TCP connection, point it to localhost:6379 where redis-main is running
  systemd.services.immich-server.serviceConfig.Environment = [
    "REDIS_HOSTNAME=127.0.0.1"
    "REDIS_PORT=6379"
  ];

  networking.firewall.allowedTCPPorts = [ 2283 ];
}