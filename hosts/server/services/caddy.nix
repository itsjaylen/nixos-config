{ config, pkgs, ... }: {
  services.caddy = {
    enable = true;
    configFile = pkgs.writeText "Caddyfile" ''
      http://git.home {
        reverse_proxy http://127.0.0.1:3000
      }
    '';
    # Key: disable NixOS default hardening that may cause Caddy to fail to start
    # Allow Caddy to write its own state directory (certificates, autosave, etc.)
    # and not be restricted by DynamicUser
    user = "caddy";
    group = "caddy";
    # If the module still has issues, you can use the following line to fully open up permissions
    # (not recommended for production, but for debugging confirm whether it's a permissions issue)
    # extraConfig = "";
  };

  # Ensure the caddy user and group exist (if the module doesn't create them by default)
  users.users.caddy = {
    isSystemUser = true;
    group = "caddy";
  };
  users.groups.caddy = {};

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}