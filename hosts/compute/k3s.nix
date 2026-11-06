{ config, ... }:

{
  services.k3s = {
    enable = true;
    role = "agent";
    serverAddr = "https://<server-LAN-IP>:6443";
    tokenFile = config.sops.secrets."k3s/node-token".path;
  };

  networking.firewall.allowedTCPPorts = [ 10250 ];
}