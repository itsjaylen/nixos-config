{ config, pkgs, ... }: {
  microvm.vms.qbittorrent = {
    autostart = true;
    vcpu = 1;
    mem = 256;

    # Define the network interface attached to the microVM
    interfaces = [
      {
        type = "user"; # User-mode networking (SLiRP), requires no extra host bridge setup
        id = "qbt-net";
      }
    ];

    config = {
      imports = [
        ../../modules/core/nixpkgs.nix
      ];

      system.stateVersion = "26.05";

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