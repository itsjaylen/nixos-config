{ pkgs, ... }: {
  services.cockpit = {
    enable = true;
    port = 9191; 
  };

  networking.firewall.allowedTCPPorts = [ 9191 ];
}