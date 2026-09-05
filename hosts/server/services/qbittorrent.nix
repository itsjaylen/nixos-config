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
                  Username = "admin";
                  Password_PBKDF2 = "@ByteArray(EjRWeJCrze/FM5BxmaFbFkXS0XSGwU5jbBsE5J3N6MzqSExdnBukZic1Ar+MGFTxesc5jTyLih+mL9r1KaWrDODpVlHXTtxb)";
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