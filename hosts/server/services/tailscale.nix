{ config, ... }:
{
  services.tailscale.enable = true;
  services.tailscale.extraUpFlags = [ "--ssh" ];
  services.tailscale.extraSetFlags = [ "--accept-dns=false" ];
  networking.firewall = {
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
  };
}