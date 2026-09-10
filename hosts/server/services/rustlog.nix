{ config, lib, pkgs, inputs, ... }:

{
  sops.secrets."rustlog/config" = {
    owner = "rustlog";
    group = "rustlog";
    path = "/var/lib/rustlog/config.json";
    mode = "0400";
  };

  systemd.services.rustlog = {
    description = "Rustlog Twitch Logging Service";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" "clickhouse.service" ];
    requires = [ "clickhouse.service" ];

    serviceConfig = {
      Type = "simple";
      User = "rustlog";
      Group = "rustlog";
      ExecStart = "${inputs.self.packages.${pkgs.system}.rustlog}/bin/rustlog";
      WorkingDirectory = "/var/lib/rustlog";
      Restart = "always";
      RestartSec = "5s";
      
      DynamicUser = false;
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
  networking.firewall.allowedTCPPorts = [ 8025 ];
}