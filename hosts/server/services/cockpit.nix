{ pkgs, ... }: {
  services.cockpit = {
    enable = true;
    port = 9191;
    settings = {
      WebService = {
        OriginCheck = false; # Or explicitly add allowed origins if preferred
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 9191 ];
}