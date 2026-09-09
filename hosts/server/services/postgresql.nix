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
}