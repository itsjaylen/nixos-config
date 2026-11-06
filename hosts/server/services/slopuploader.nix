{ config, pkgs, inputs, ... }: {
  imports = [ inputs.slopuploader.nixosModules.default ];

  sops.templates."slopuploader.env" = {
    content = ''
      ADMIN_TOKEN=${config.sops.placeholder."slopuploader/admin_token"}
      S3_ACCESS_KEY=${config.sops.placeholder."slopuploader/s3_access_key"}
      S3_SECRET_KEY=${config.sops.placeholder."slopuploader/s3_secret_key"}
      DB_PASSWORD=${config.sops.placeholder."slopuploader/db_password"}
    '';
  };

  services.slopuploader = {
    enable = true;
    port = 8889;
    baseUrl = "http://192.168.50.188:8889";

    settings = {
      dbType = "postgres";
      dbConn = "host=/var/run/postgresql user=slopuploader dbname=slopuploader sslmode=disable";
      storageType = "s3";
      s3Endpoint = "http://192.168.50.188:3900";
      s3Bucket = "slopuploader-files";
      s3Region = "garageland";
    };

    environmentFile = config.sops.templates."slopuploader.env".path;
  };

  networking.firewall.allowedTCPPorts = [ 8889 ];
}