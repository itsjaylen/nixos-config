{ config, pkgs, ... }:

let
  dbPassword    = config.sops.secrets."planly_db_password".path;
  jwtSecret     = config.sops.secrets."planly_jwt_secret".path;
  encryptionKey = config.sops.secrets."planly_encryption_key".path;
  s3AccessKey   = config.sops.secrets."garage_s3_access_key".path;
  s3SecretKey   = config.sops.secrets."garage_s3_secret_key".path;
in
{
  virtualisation.oci-containers.containers = {
    planly-backend = {
      image = "planly-backend:latest";
      autoStart = true;
      environment = {
        DATABASE_URL         = "postgresql://planly:${builtins.readFile dbPassword}@127.0.0.1:5432/planly";
        DB_PASSWORD          = builtins.readFile dbPassword;
        JWT_SECRET           = builtins.readFile jwtSecret;
        ENCRYPTION_KEY       = builtins.readFile encryptionKey;
        ADMIN_EMAIL          = "you@example.com";                 # <-- change
        FRONTEND_ORIGIN      = "http://your-server-ip:8080";      # <-- change
        APP_URL              = "http://your-server-ip:8080";      # <-- change
        COOKIE_SECURE        = "false";                           # no TLS yet
        TRUSTED_PROXY_DEPTH  = "0";

        S3_BUCKET            = "planly-uploads";
        S3_REGION            = "garageland";
        S3_ENDPOINT          = "http://127.0.0.1:3900";
        S3_ACCESS_KEY_ID     = builtins.readFile s3AccessKey;
        S3_SECRET_ACCESS_KEY = builtins.readFile s3SecretKey;
      };
      volumes = [ "planly-data:/app/data" ];
      extraOptions = [ "--network=host" ];
    };

    planly-frontend = {
      image = "planly-frontend:latest";
      autoStart = true;
      ports = [ "8080:80" ];
      environment = {
        BACKEND_URL = "http://127.0.0.1:3000";
      };
      extraOptions = [ "--network=host" ];
    };
  };
}