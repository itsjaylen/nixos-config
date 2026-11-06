{ config, ... }:

{
  services.k3s = {
    enable = true;
    role = "agent";
    serverAddr = "https://192.168.50.188:6443";
    tokenFile = config.sops.secrets."k3s/node-token".path;
    extraFlags = [ "--node-label=role=small-services" ];
  };

  networking.firewall = {
    allowedTCPPorts = [ 10250 ];
    allowedUDPPorts = [ 8472 ];  # Flannel VXLAN
  };
}