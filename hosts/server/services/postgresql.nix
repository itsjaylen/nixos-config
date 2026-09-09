{ config, pkgs, lib, ... }: {
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
  
    settings.listen_addresses = lib.mkForce "*";
  
    # Allow password-less trust connections from your local subnet over TCP
    authentication = lib.mkOverride 10 ''
      # type database  user-name  address-origin  auth-method
      host  all        all        192.168.50.0/24 trust
    '';
  
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