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

    redis = {
      host = "127.0.0.1";
      port = 6379;
    };
  };

  networking.firewall.allowedTCPPorts = [ 2283 ];
}