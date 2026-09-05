{ config, pkgs, lib, ... }: {
  microvm.vms.qbittorrent = {
    autostart = true;

    config = {
      imports = [
        ../../../modules/core/nixpkgs.nix
      ];

      system.stateVersion = "26.05";

      microvm.mem = 256;
      microvm.vcpu = 1;

      microvm.interfaces = [
        {
          type = "user";
          id = "qbt-net";
          mac = "02:00:00:00:00:01";
        }
      ];

      microvm.forwardPorts = [
        {
          from = "host";
          host.port = 5000;
          guest.port = 5000;
        }
      ];

      services.cloudflare-warp = {
        enable = true;
      };

      # Raw systemd service definition replacing the broken module
      systemd.services.qbittorrent = {
        enable = true;
        unitConfig = {
          After = [ "network-online.target" ];
        };
        serviceConfig = {
          Type = "exec";
          User = "qbittorrent";
          Group = "qbittorrent";
          DynamicUser = true; # Automatically creates the user/group securely
          Restart = "always";
          RestartSec = 3;
          ExecStart = "${lib.getExe' pkgs.qbittorrent-nox "qbittorrent-nox"} --webui-port=5000";
          StandardError = "journal";
          StandardOutput = "journal";
        };
        wantedBy = [ "multi-user.target" ];
      };

      # Explicitly declare the qbittorrent user and group for state persistence
            users.users.qbittorrent = {
              isSystemUser = true;
              group = "qbittorrent";
              home = "/var/lib/qbittorrent";
              createHome = true;
            };
            users.groups.qbittorrent = {};

      microvm.shares = [{
        tag = "ro-store";
        source = "/nix/store";
        mountPoint = "/nix/store";
        proto = "virtiofs";
      }];

      networking.useDHCP = true;
    };
  };
  networking.firewall.allowedTCPPorts = [ 5000 ];
}