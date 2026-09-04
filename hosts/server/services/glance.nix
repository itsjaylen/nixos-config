{ ... }: {
  services.glance = {
    enable = true;
    settings = {
      server = {
        port = 8080;
        host = "0.0.0.0";
      };
      pages = [
        {
          name = "Home";
          columns = [
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
                        { title = "Garage S3"; url = "http://localhost:3900"; }
                        { title = "Grafana"; url = "http://localhost:3001"; }
                      ];
                    }
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