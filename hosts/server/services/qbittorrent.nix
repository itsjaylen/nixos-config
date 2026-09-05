{ config, pkgs, ... }: {
  microvm.vms.qbittorrent = {
    autostart = true;
    vcpu = 1;
    mem = 256;

    config = {
      imports = [
        ../../modules/core/nixpkgs.nix
      ];

      system.stateVersion = "26.05";

      # Interfaces belong inside the microVM's own configuration block
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