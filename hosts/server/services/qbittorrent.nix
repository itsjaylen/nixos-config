{ config, pkgs, ... }: {
  microvm.vms.qbittorrent = {
    autostart = true;

    config = {
      imports = [
        # Correct path from hosts/server/services/ back to modules/core/
        ../../../modules/core/nixpkgs.nix
      ];

      system.stateVersion = "26.05";

      microvm.mem = 256;
      microvm.vcpu = 1;

      microvm.interfaces = [
        {
          type = "user";
          id = "qbt-net";
        }
      ];

      services.cloudflare-warp = {
        enable = true;
      };

      services.qbittorrent = {
        enable = true;
        openFirewall = true;
        webuiPort = 9090;
        serverConfig = {
          Preferences = {
            Connection = {
              Interface = "CloudflareWARP";
            };
            LegalNotice = {
              Accepted = true;
            };
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
}