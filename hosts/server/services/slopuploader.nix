{ config, pkgs, inputs, ... }: {
  imports = [
    inputs.slopuploader.nixosModules.default
  ];

  services.slopuploader = {
    enable = true;
    port = 8080;
    baseUrl = "0.0.0.0"; # Or your local domain/IP

    settings = {
      dbType = "postgres";
      dbConn = "host=localhost user=slopuploader dbname=slopuploader sslmode=disable client_encoding=UTF8";
      storageType = "s3";
      s3Endpoint = "http://192.168.50.188:3900"; # Your Garage S3 instance
      s3Bucket = "slopuploader-files";
      s3Region = "garageland";
    };

    # Point to your sops-nix secret file containing ADMIN_TOKEN and S3 keys
    environmentFile = config.sops.secrets."slopuploader/env".path;
  };
}