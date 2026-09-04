{ config, pkgs, ... }: {
  # Format secret as an environment variable file for Garage
  sops.templates."garage-env" = {
    content = ''
      GARAGE_RPC_SECRET=${config.sops.placeholder.garage_rpc_secret}
    '';
    owner = "garage";
  };

  services.garage = {
    enable = true;
    package = pkgs.garage;

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

  # Feed the sops template into garage.service
  systemd.services.garage.serviceConfig = {
    EnvironmentFile = config.sops.templates."garage-env".path;
  };

  networking.firewall.allowedTCPPorts = [ 3900 ];
}