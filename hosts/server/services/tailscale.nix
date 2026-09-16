{ config, ... }:
{
  services.tailscale.enable = true;
  services.tailscale.extraUpFlags = [ "--ssh" ];
  networking.firewall = {
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
  };
}