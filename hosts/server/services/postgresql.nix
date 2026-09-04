{ config, pkgs, ... }: {
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;

    # Pre-create database users and their dedicated databases
    ensureDatabases = [
      "gitea"
    ];
    ensureUsers = [
      {
        name = "gitea";
        ensureDBOwnership = true;
      }
    ];
  };
}