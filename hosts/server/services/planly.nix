{ config, pkgs, ... }:

let
  # We no longer read files directly here.
  # The template below handles the placeholder logic.
in
{
  # Create a single environment file containing all secrets for Planly
  sops.templates."planly-env" = {
    content = ''
      DB_PASSWORD=${config.sops.placeholder.planly_db_password}
      DATABASE_URL=postgresql://planly:${config.sops.placeholder.planly_db_password}@127.0.0.1:5432/planly
      JWT_SECRET=${config.sops.placeholder.planly_jwt_secret}
      ENCRYPTION_KEY=${config.sops.placeholder.planly_encryption_key}
      S3_ACCESS_KEY_ID=${config.sops.placeholder.garage_s3_access_key}
      S3_SECRET_ACCESS_KEY=${config.sops.placeholder.garage_s3_secret_key}
    '';
    owner = "root"; # Or the podman user if you use rootless podman
  };

  virtualisation.oci-containers.containers = {
    planly-backend = {
      image = "planly-backend:latest";
      autoStart = true;

      # Non-secret environment variables can stay here
      environment = {
        ADMIN_EMAIL = "you@example.com";
        FRONTEND_ORIGIN = "http://192.168.50.188:8085";
        APP_URL = "http://192.168.50.188:8085";
        COOKIE_SECURE = "false";
        TRUSTED_PROXY_DEPTH = "0";
        S3_BUCKET = "planly-uploads";
        S3_REGION = "garageland";
        S3_ENDPOINT = "http://127.0.0.1:3900";
      };

      # This is the key: pass the decrypted template file here
      environmentFiles = [
        config.sops.templates."planly-env".path
      ];

      volumes = [ "planly-data:/app/data" ];
      extraOptions = [ "--network=host" ];
    };

    planly-frontend = {
      image = "planly-frontend:latest";
      autoStart = true;
      ports = [ "8085:85" ];
      environment = {
        BACKEND_URL = "http://127.0.0.1:3000";
      };
      extraOptions = [ "--network=host" ];
    };
  };
}