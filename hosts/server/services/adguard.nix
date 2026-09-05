{ config, pkgs, ... }: {
  services.adguardhome = {
    enable = true;
    host = "0.0.0.0";
    port = 3005;
    settings = {
      dns = {
        bind_hosts = [ 
          "127.0.0.1" 
          "192.168.50.188" 
        ];
        port = 53;
        # Use clean IP-only upstream definitions
        upstream_dns = [
          "9.9.9.9"
          "149.112.112.112"
          "1.1.1.1"
        ];
        # Explicitly define bootstrap resolvers for safety
        bootstrap_dns = [
          "9.9.9.9"
          "1.1.1.1"
        ];
      };
      dhcp = {
        enabled = false;
      };
      filters = [
        {
          enabled = true;
          url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt";
          name = "AdGuard DNS filter";
        }
        {
          enabled = true;
          url = "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt";
          name = "uBlock Origin – Filters";
        }
        {
          enabled = true;
          url = "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt";
          name = "uBlock Origin – Badware risks";
        }
        {
          enabled = true;
          url = "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt";
          name = "uBlock Origin – Privacy";
        }
        {
          enabled = true;
          url = "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt";
          name = "uBlock Origin – Annoyances";
        }
        {
          enabled = true;
          url = "https://raw.githubusercontent.com/yokoffing/filterlists/main/privacy_essentials.txt";
          name = "Yokoffing Privacy Essentials";
        }
        {
          enabled = true;
          url = "https://raw.githubusercontent.com/yokoffing/filterlists/main/annoyance_list.txt";
          name = "Yokoffing Annoyances";
        }
        {
          enabled = true;
          url = "https://raw.githubusercontent.com/yokoffing/filterlists/main/youtube_clear_view.txt";
          name = "Yokoffing YouTube Clear View";
        }
        {
          enabled = true;
          url = "https://raw.githubusercontent.com/yokoffing/filterlists/main/click2load.txt";
          name = "Yokoffing Click2Load";
        }
        {
          enabled = true;
          url = "https://raw.githubusercontent.com/yokoffing/filterlists/main/clean_reading_experience.txt";
          name = "Yokoffing Clean Reading Experience";
        }
        {
          enabled = true;
          url = "https://v.firebog.net/hosts/AdguardDNS.txt";
          name = "Firebog Trusted";
        }
      ];
      user_rules = [
        "||ads.example.com^"
        "||trackers.example.org^"
      ];
    };
  };

  networking.firewall.allowedTCPPorts = [ 3005 53 ];
  networking.firewall.allowedUDPPorts = [ 53 ];
}