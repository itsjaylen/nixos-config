{ ... }: {
  services.glance = {
    enable = true;
    settings = {
      server = {
        port = 8080;
        host = "0.0.0.0";
      };
      theme = {
        background-color = "220 15 15";
        primary-color = "200 80 50";
        contrast-multiplier = 1.1;
      };
      pages = [
        {
          name = "Home";
          columns = [
            {
              size = "small";
              widgets = [
                {
                  type = "weather";
                  location = "Atlanta, GA";
                  units = "imperial";
                  hour-format = "12h";
                }
                {
                  type = "calendar";
                }
              ];
            }
            {
              size = "full";
              widgets = [
                {
                  type = "group";
                  widgets = [
                    {
                      type = "monitor";
                      title = "Core Infrastructure";
                      sites = [
                        { title = "Gitea"; url = "http://localhost:3000"; }
                        { title = "Garage S3"; url = "http://localhost:3900"; alt-status-codes = [ 403 ]; }
                        { title = "Grafana"; url = "http://localhost:3001"; }
                        { title = "AdGuard Home"; url = "http://localhost:3005"; }
                      ];
                    }
                  ];
                }
                {
                  type = "rss";
                  title = "Tech News";
                  limit = 5;
                  feeds = [
                    { title = "Hacker News"; url = "https://news.ycombinator.com/rss"; }
                    { title = "NixOS Blog"; url = "https://nixos.org/blog/announcements-rss.xml"; }
                  ];
                }
              ];
            }
          ];
        }
      ];
    };
  };

  networking.firewall.allowedTCPPorts = [ 8080 ];
}