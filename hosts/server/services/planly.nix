{ config, pkgs, lib, ... }:

{
  # ── Container definitions ─────────────────────────────────────────────────
  virtualisation.oci-containers.containers = {

    # ── Backend ─────────────────────────────────────────────────────────────
    planly-backend = {
      # Image must be built locally first:
      #   git clone https://github.com/esbeneickhardt/Planly.git ~/Planly
      #   cd ~/Planly
      #   podman build -t planly-backend:latest ./backend
      # Podman resolves local-only images via the "localhost/" prefix.
      image = "localhost/planly-backend:latest";
      autoStart = true;

      environment = {
        # ── Database ────────────────────────────────────────────────────────
        # Points at the host's PostgreSQL, which listens on all interfaces.
        # Use the LAN IP so it matches the pg_hba.conf 192.168.50.0/24 rule.
        # Adjust 192.168.50.1 if your server's LAN IP differs.
        DATABASE_URL = "postgresql://planly:CHANGE_ME@192.168.50.1:5432/planly";

        # ── Mandatory secrets ───────────────────────────────────────────────
        # Generate each with: openssl rand -hex 32
        # NOTE: hardcoding these in Nix puts them in the world-readable Nix
        # store. Use sops-nix with environmentFiles for production.
        JWT_SECRET = "CHANGE_ME_openssl_rand_hex_32";
        ENCRYPTION_KEY = "CHANGE_ME_openssl_rand_hex_32";

        # ── Admin account ───────────────────────────────────────────────────
        # Required - first user to register with this email becomes founding admin.
        ADMIN_EMAIL = "you@example.com";
        # Optional: set a known password instead of a randomly generated one.
        # ADMIN_PASSWORD = "CHANGE_ME";

        # ── Server ──────────────────────────────────────────────────────────
        # Origin the browser uses to reach the frontend. Must match what users
        # type in the address bar, or CSRF/WebSocket checks will fail.
        FRONTEND_ORIGIN = "http://192.168.50.1:8734";
        UPLOADS_DIR = "/data/uploads";
        NODE_ENV = "production";

        # Number of reverse-proxy hops in front of the backend.
        # 0 = direct access, 1 = one reverse proxy (Nginx/Caddy).
        TRUSTED_PROXY_DEPTH = "0";

        # Set "false" for plain HTTP; "true" when serving over HTTPS.
        COOKIE_SECURE = "false";

        # ── Optional ────────────────────────────────────────────────────────
        LOG_LEVEL = "info";
        RATE_LIMIT_LOGIN_MAX = "10";
        RATE_LIMIT_REGISTER_MAX = "5";
        ADMIN_LOG_RETENTION_DAYS = "90";
      };

      # Backend is intentionally NOT exposed to the host.
      # Uncomment the line below only for temporary debugging.
      # ports = [ "127.0.0.1:8735:3000" ];

      volumes = [
        "/var/lib/planly/uploads:/data/uploads"
      ];

      # No dependsOn here — see the systemd service override below for ordering.
      dependsOn = [ ];
    };

    # ── Frontend ────────────────────────────────────────────────────────────
    planly-frontend = {
      # Build with:
      #   podman build -t planly-frontend:latest ./frontend
      image = "localhost/planly-frontend:latest";
      autoStart = true;

      environment = {
        # Nginx inside the frontend container proxies /api requests to the
        # backend. Check the frontend's nginx.conf for the exact variable name
        # — it may be hardcoded to "backend:3000" from the Compose setup. If
        # so, either rename this container or override the nginx config.
        BACKEND_URL = "http://planly-backend:3000";
      };

      # Frontend is the only publicly reachable part of Planly.
      # Bind to the host and let a real reverse proxy (Caddy/Nginx) sit in
      # front for TLS. Internal port stays 80; only the host port changed.
      ports = [ "0.0.0.0:8734:80" ];

      dependsOn = [ "planly-backend" ];
    };
  };

  # ── Persistent directories ──────────────────────────────────────────────────
  systemd.tmpfiles.rules = [
    "d /var/lib/planly 0750 root root -"
    "d /var/lib/planly/uploads 0750 root root -"
  ];

  # ── Startup ordering ────────────────────────────────────────────────────────
  systemd.services."podman-planly-backend" = {
    after = [ "postgresql.service" "network-online.target" ];
    requires = [ "postgresql.service" ];
    wants = [ "network-online.target" ];
  };

  systemd.services."podman-planly-frontend" = {
    after = [ "podman-planly-backend.service" ];
    requires = [ "podman-planly-backend.service" ];
  };

  # ── Firewall ────────────────────────────────────────────────────────────────
  # Open the frontend port to the LAN so other machines can reach Planly.
  networking.firewall.allowedTCPPorts = [ 8734 ];
}