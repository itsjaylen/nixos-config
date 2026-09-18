{ pkgs, host, config, ... }:
{
  networking = {
    hostName = "${host}";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
        59010
        59011
        25565
      ];
      allowedUDPPorts = [
        59010
        59011
        config.services.tailscale.port
      ];
      trustedInterfaces = [ "tailscale0" ];
    };
  };

  services.tailscale.enable = true;

  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}