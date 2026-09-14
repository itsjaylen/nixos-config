{ config, pkgs, lib, ... }: {
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;

    settings.listen_addresses = lib.mkForce "*";

    ensureDatabases = [
      "gitea"
      "immich"
      "slopuploader"
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
    ];
  };
  services.postgresql.authentication = lib.mkOverride 10 ''
    # Local socket connections — required for the postgres user and systemd
    local   all   all                       peer

    # IPv4 localhost
    host    all   all   127.0.0.1/32        scram-sha-256

    # IPv6 localhost
    host    all   all   ::1/128             scram-sha-256

    # LAN — allow the k3s agent and any other LAN host
    host    all   all   192.168.50.0/24     scram-sha-256
  '';
  networking.firewall.allowedTCPPorts = [ 3900 5432 ];
}