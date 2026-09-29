{ config, pkgs, lib, ... }:

{
  virtualisation.oci-containers.containers = {
    planly-backend = {
      image = "esbeneickhardt/planly-backend:latest";
      autoStart = true;
      environment = {
        # Point Planly to the native PostgreSQL service.
        # Use the host's LAN IP so it goes through the authenticated host rule
        # (host.containers.internal may resolve to an address not covered by pg_hba).
        DATABASE_URL = "postgresql://planly:CHANGE_ME@192.168.50.1:5432/planly";

        # --- Required secrets (from Planly's .env.example) ---
        # Generate with: openssl rand -hex 32
        # Ideally inject via sops-nix environmentFiles instead of hardcoding.
        JWT_SECRET = "CHANGE_ME_openssl_rand_hex_32";
        ENCRYPTION_KEY = "CHANGE_ME_openssl_rand_hex_32";

        # Founding admin account
        ADMIN_EMAIL = "you@example.com";
        # ADMIN_PASSWORD = "..."; # optional; random one is logged if unset

        # Other common vars — check Planly's .env.example for the full list
        NODE_ENV = "production";
        PORT = "3000";
        UPLOADS_DIR = "/app/uploads";
      };
      ports = [ "127.0.0.1:3000:3000" ];
      volumes = [ "/var/lib/planly/uploads:/app/uploads" ];
      # Ensure the DB is up before the backend starts
      dependsOn = [ ];
    };

    planly-frontend = {
      image = "esbeneickhardt/planly-frontend:latest";
      autoStart = true;
      environment = {
        # Browser-facing API URL (served via your reverse proxy)
        API_URL = "http://127.0.0.1:3000";
      };
      ports = [ "127.0.0.1:8080:80" ];
      dependsOn = [ "planly-backend" ];
    };
  };

  # Make sure the uploads dir exists with sane perms before the container starts
  systemd.tmpfiles.rules = [
    "d /var/lib/planly/uploads 0750 root root -"
  ];

  # Startup ordering: backend after postgres, frontend after backend
  systemd.services."podman-planly-backend" = {
    after = [ "postgresql.service" "network-online.target" ];
    requires = [ "postgresql.service" ];
    wants = [ "network-online.target" ];
  };
  systemd.services."podman-planly-frontend" = {
    after = [ "podman-planly-backend.service" ];
    requires = [ "podman-planly-backend.service" ];
  };
}