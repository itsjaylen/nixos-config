{ pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [
    6443 # API server
  ];

  services.k3s.enable = true;
  services.k3s.role = "server";
  services.k3s.extraFlags = [
    "--write-kubeconfig-mode 640"
    "--write-kubeconfig-group k3sconfig"
  ];
  
  users.groups.k3sconfig = {};
  users.users.jaylen.extraGroups = [ "k3sconfig" ];

  environment.systemPackages = [ pkgs.k3s ];
}