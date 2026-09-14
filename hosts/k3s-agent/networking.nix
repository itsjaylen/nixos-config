{
  networking.firewall = {
    allowedTCPPorts = [ 30080 ];
    trustedInterfaces = [ "cni0" "flannel.1" ];
    # Or more aggressively, allow the pod CIDR:
    extraForwardRules = ''
      iifname "cni0" accept
      iifname "flannel.1" accept
      ip saddr 10.42.0.0/16 accept
      ip daddr 10.42.0.0/16 accept
      --flannel-iface=enp7s0"
    '';
  };
  networking.firewall.checkReversePath = "loose";
}