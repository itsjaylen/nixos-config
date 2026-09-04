{ config, pkgs, ... }: {
  services.garage = {
    enable = true;
    settings = {
      replication_factor = 1;
      rpc_bind_addr = "[::]:3901";
      
      s3_api = {
        s3_region = "garageland";
        api_bind_addr = "127.0.0.1:3900";
        root_domain = ".s3.garage.localhost";
      };

      storage = {
        engine = "sqlite";
        data_dir = "/var/lib/garage/data";
        metadata_dir = "/var/lib/garage/meta";
      };
    };
  };

  # Open port for local access if needed
  networking.firewall.allowedTCPPorts = [ 3900 ];
}