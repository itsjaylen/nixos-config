{ config, pkgs, ... }: {
  # Define the microVM on the host system
  microvm.vms.qbittorrent = {
    autostart = true;
    restartTriggers = [ ];
    mem = 256; # MB of RAM
    cores = 1;
    
    # Networking for the microVM (using SLIRP or bridge)
    networking.primaryInterface = "enp1s0"; # Adjust if using a bridged setup

    config = {

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

      # Share the host's /nix/store to keep disk usage near zero inside the VM
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