{ config, pkgs, ... }: {
  microvm.vms.qbittorrent = {
    autostart = true;
    vcpu = 1;
    
    networking.primaryInterface = "enp1s0";

    config = {
      imports = [
        ../../modules/core/nixpkgs.nix
      ];

      system.stateVersion = "26.05";

      microvm.mem = 256;

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