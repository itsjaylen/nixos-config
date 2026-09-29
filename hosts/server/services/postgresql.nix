{ config, pkgs, lib, ... }: {
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;

    settings.listen_addresses = lib.mkForce "*";

    ensureDatabases = [
      "gitea"
      "immich"
      "slopuploader"
      "planly"
    ];
    ensureUsers = [
      {
        name = "gitea";
        ensureDBOwnership = true;
      }
      {
        name = "immich";
        ensureDBOwnership = true;
      }
      {
        name = "slopuploader";
        ensureDBOwnership = true;
      }
      {
        name = "planly";
        ensureDBOwnership = true;
      }
    ];

    # Runs after PostgreSQL starts. Reads the decrypted SOPS secret from
    # /run/secrets/planly_db_password and applies it to the planly role.
    # This keeps the password out of the Nix store and ensures the DB
    # password always matches what the Planly container receives.
    postStart = let
      passwordFile = config.sops.secrets."planly_db_password".path;
    in ''
      $PSQL -tA <<'EOF'
      DO $$
      DECLARE
        pw text;
      BEGIN
        pw := trim(both from replace(pg_read_file('${passwordFile}'), E'\n', ''));
        EXECUTE format('ALTER USER planly WITH PASSWORD %L', pw);
      END
      $$;
      EOF
    '';
  };

  services.postgresql.authentication = lib.mkOverride 10 ''
    # Existing local access
    local   all   all                       peer

    # IPv4 localhost
    host    all   all   127.0.0.1/32        scram-sha-256

    # IPv6 localhost
    host    all   all   ::1/128             scram-sha-256

    # LAN — laptop, desktop, etc.
    host    all   all   192.168.50.0/24     scram-sha-256

    # Kubernetes pod CIDR — for pods running on any cluster node
    host    all   all   10.42.0.0/16        scram-sha-256
  '';

  networking.firewall.allowedTCPPorts = [ 3900 5432 ];
}