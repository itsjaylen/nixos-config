{ config, pkgs, ... }: {
  services.cloudflare-warp = {
    enable = true;
  };

  sops.secrets.qbittorrent_password = {
    sopsFile = ../../secrets/secrets.yaml;
    owner = "qbittorrent";
    group = "qbittorrent";
    mode = "0400";
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
        WebUI = {
          PasswordFile = config.sops.secrets.qbittorrent_password.path;
        };
      };
      LegalNotice = {
        Accepted = true;
      };
    };
  };
}