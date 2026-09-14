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