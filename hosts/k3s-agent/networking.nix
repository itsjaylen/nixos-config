{
  networking.firewall = {
    allowedTCPPorts = [ 30080 ];
    allowedUDPPorts = [ 8472 ];  # Flannel VXLAN
    trustedInterfaces = [ "cni0" "flannel.1" ];
    extraForwardRules = ''
      iifname "cni0" accept
      iifname "flannel.1" accept
      ip saddr 10.42.0.0/16 accept
      ip daddr 10.42.0.0/16 accept
    '';
  };
  networking.firewall.checkReversePath = "loose";
}