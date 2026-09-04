{ config, pkgs, ... }: {
  # Declare the secret key from secrets.yaml
  sops.secrets.cloudflare-tunnel-token = {
    # Match the key name in your secrets.yaml file
    sopsFile = ../../../secrets/secrets.yaml;
    # Ensure the cloudflared service account can read the secret file
    owner = "cloudflared";
    group = "cloudflared";
    mode = "0400";
  };

  # Enable Cloudflare Tunnel
  services.cloudflared = {
    enable = true;
    tunnels = {
      "server-tunnel" = {
        # Pass the decrypted secret file path created by sops-nix
        tokenFile = config.sops.secrets.cloudflare-tunnel-token.path;

        # Ingress rules
        ingress = {
          "git.itsjaylen.com" = "http://192.168.50.188:3000";
          default = "http_status:404";
        };
      };
    };
  };
}