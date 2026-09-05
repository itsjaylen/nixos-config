{ config, pkgs, ... }: {
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

      services.qbittorrent = {
              enable = true;
              openFirewall = true;
              webuiPort = 5000;
              serverConfig = {
                Preferences = {
                  Connection = {
                    Interface = "CloudflareWARP";
                  };
                  LegalNotice = {
                    Accepted = true;
                  };
                };
                WebUI = {
                  Address = "*";
                  LocalHostAuth = false;
                  # Bypass authentication for local network / host requests
                  AuthSubnetWhitelistEnabled = true;
                  AuthSubnetWhitelist = "0.0.0.0/0"; # Or specify your host/bridge subnet
                };
              };
            };

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