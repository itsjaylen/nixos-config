{ config, lib, pkgs, inputs, ... }:

{
  # If you want to use ClickHouse locally via systemd or docker, 
  # ensure your config.json matches the connection details.
  
  systemd.services.rustlog = {
    description = "Rustlog Twitch Logging Service";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ]; # Add "docker.clickhouse.service" or similar if hosting ClickHouse locally via systemd/docker

    serviceConfig = {
      Type = "simple";
      User = "rustlog";
      Group = "rustlog";
      ExecStart = "${inputs.self.packages.${pkgs.system}.rustlog}/bin/rustlog";
      WorkingDirectory = "/var/lib/rustlog";
      Restart = "always";
      RestartSec = "5s";
      
      # Hardening measures
      DynamicUser = false; # Set to true if you manage state dir via StateDirectory
      StateDirectory = "rustlog";
      ProtectSystem = "strict";
      ProtectHome = true;
      NoNewPrivileges = true;
    };
  };

  users.users.rustlog = {
    isSystemUser = true;
    group = "rustlog";
    home = "/var/lib/rustlog";
    createHome = true;
  };
  users.groups.rustlog = {};
}