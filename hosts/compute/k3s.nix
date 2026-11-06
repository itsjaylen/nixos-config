{ config, ... }:

{
  services.k3s = {
    enable = true;
    role = "agent";
    serverAddr = "http://192.168.50.188:6443";
    tokenFile = config.sops.secrets."k3s/node-token".path;
  };

  networking.firewall.allowedTCPPorts = [ 10250 ];
}