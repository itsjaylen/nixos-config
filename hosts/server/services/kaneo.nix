{ config, pkgs, lib, ... }:

{
  virtualisation.podman.enable = true;

  virtualisation.oci-containers.containers.kaneo = {
    image = "ghcr.io/usekaneo/kaneo:latest";
    ports = [ "5173:5173" ];
    environment = {
      DATABASE_URL = "postgresql://kaneo:YOUR_SECURE_PASSWORD@localhost:5432/kaneo";
      KANEO_CLIENT_URL = "http://localhost:5173";
      AUTH_SECRET = "e78b70798db9d359c408020115f302c77b2625679bacd8931484437b7167bd3b";
    };
    extraOptions = [ "--network=host" ];
    autoStart = true;
  };

  # Ensure firewall allows Kaneo's port
  networking.firewall.allowedTCPPorts = [ 5173 ];
}