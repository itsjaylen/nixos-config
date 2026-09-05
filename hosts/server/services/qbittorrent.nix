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

      # Write the qBittorrent configuration file with your pre-hashed password
      environment.etc."qBittorrent/qBittorrent.conf" = {
        text = ''
          [Preferences]
          Connection\Interface=CloudflareWARP
          LegalNotice\Accepted=true

          [WebUI]
          Address=*
          LocalHostAuth=false
          Username=admin
          Password_PBKDF2=@ByteArray(HGtDalIr2OpxnZjQ1uzIGQ==:covuupiN1IIL/wZt7/FX2+Gw7PKjpRrCU7yQwAMs9/7WyXyF5PUplznPKAlApUuOpisDk7TDjwyjDbTyALZ/Eg==)
        '';
      };

      systemd.services.qbittorrent = {
        enable = true;
        unitConfig = {
          After = [ "network-online.target" ];
        };
        serviceConfig = {
          Type = "exec";
          User = "qbittorrent";
          Group = "qbittorrent";
          Restart = "always";
          RestartSec = 3;
          # Point qbittorrent-nox to read the config directory
          ExecStart = "${lib.getExe' pkgs.qbittorrent-nox "qbittorrent-nox"} --webui-port=5000 --profile=/var/lib/qbittorrent";
          StandardError = "journal";
          StandardOutput = "journal";
        };
        wantedBy = [ "multi-user.target" ];
      };

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