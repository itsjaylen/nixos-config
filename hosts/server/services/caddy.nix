{ config, pkgs, ... }: {
  services.caddy = {
    enable = true;

    # Write the whole site config directly — full control over listen address
    extraConfig = ''
      http://git.home {
        reverse_proxy http://127.0.0.1:3000
      }
    '';
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}