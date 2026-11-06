{ config, pkgs, lib, ... }:

{
  # ---------------------------------------------------------------------------
  # k3s control plane for the home cluster.
  #
  # The desktop joins as an agent (see hosts/desktop/k3s.nix).
  # Flux (manifests/flux-system/) takes over workload management from here,
  # so keep this deliberately minimal.
  # ---------------------------------------------------------------------------
  services.k3s = {
    enable = true;
    role = "server";

    extraFlags = [
      "--disable=traefik"        # cloudflared.nix handles ingress/egress
      "--disable=servicelb"      # no LoadBalancer services at home
      "--write-kubeconfig-mode=0644"
    ];
  };

  # k3s API + Flannel VXLAN need to be reachable from the desktop agent.
  networking.firewall.allowedTCPPorts = [ 6443 ];
  networking.firewall.allowedUDPPorts = [ 8472 ];

  # So `kubectl` works in your fish shell without sudo.
  environment.sessionVariables.KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";

  # The 1660 Super's driver comes from custom.hardware.nvidia.enable +
  # nvidia-container-toolkit (declared in default.nix). k3s uses containerd,
  # so point it at the runtime nvidia-container-toolkit installs.
  systemd.services.k3s.serviceConfig.Environment = [
    "K3S_KUBECONFIG_MODE=644"
  ];
}