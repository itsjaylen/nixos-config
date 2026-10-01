{ config, pkgs, lib, ... }:

{
  virtualisation.podman.enable = true;

  virtualisation.oci-containers.containers.kaneo = {
    image = "ghcr.io/usekaneo/kaneo:latest";
    ports = [ "5173:5173" ];
    environment = {
      DATABASE_URL = "postgresql://kaneo:YOUR_SECURE_PASSWORD@localhost:5432/kaneo";
      KANEO_CLIENT_URL = "http://localhost:5173";
      AUTH_SECRET = "GENERATE_A_32_CHAR_SECRET";
    };
    extraOptions = [ "--network=host" ];
    autoStart = true;
  };

  # Ensure firewall allows Kaneo's port
  networking.firewall.allowedTCPPorts = [ 5173 ];
}