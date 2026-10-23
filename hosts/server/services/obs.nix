{ pkgs, ... }:

{
  # 1. Enable Docker (if not already enabled)
  virtualisation.docker.enable = true;

  # 2. Declare the OBS container using NixOS's native OCI container support
  virtualisation.oci-containers.containers.obs = {
    image = "ghcr.io/dilllxd/obs-distroav:intel";
    ports = [ "6081:6081" "4455:4455" ];
    extraOptions = [
      "--device=/dev/dri:/dev/dri"
      "--ulimit" "nofile=65536:65536"  # Cap the fd limit to avoid x11vnc sweep hang
    ];
    volumes = [ "/var/lib/obs-config:/root/.config/obs-studio" ];
    environment = { RESOLUTION = "1920x1080"; };
    # Do NOT set cmd; let the image's default entrypoint run
  };

  # 3. Open the firewall port for noVNC
  networking.firewall.allowedTCPPorts = [ 6081 ];
}