{ config, pkgs, inputs, ... }: {
  imports = [
    inputs.slopuploader.nixosModules.default
  ];

  services.slopuploader = {
    enable = true;
    port = 8888;
    baseUrl = "http://192.168.50.188:8888";

    settings = {
      dbType = "postgres";
      dbConn = "host=/var/run/postgresql user=slopuploader dbname=slopuploader sslmode=disable";
      storageType = "s3";
      s3Endpoint = "http://192.168.50.188:3900";
      s3Bucket = "slopuploader-files";
      s3Region = "garageland";
    };

    environmentFile = config.sops.secrets."slopuploader/env".path;
  };

  networking.firewall.allowedTCPPorts = [ 8888 ];
}