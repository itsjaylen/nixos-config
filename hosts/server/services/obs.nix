{ pkgs, ... }:

{
  # 1. Enable Docker (if not already enabled)
  virtualisation.docker.enable = true;

  # 2. Declare the OBS container using NixOS's native OCI container support
  virtualisation.oci-containers.containers.obs = {
    image = "ghcr.io/dilllxd/obs-distroav:intel";
    ports = [ "6081:6081" "4455:4455" ]; # Add 4455 for ingestgo later
    extraOptions = [ "--device=/dev/dri:/dev/dri" ];
    volumes = [ "/var/lib/obs-config:/root/.config/obs-studio" ];
    environment = { RESOLUTION = "1920x1080"; };
    
    # Cap the fd limit before x11vnc starts
    cmd = [ "bash" "-c" "ulimit -n 65536; exec /entrypoint.sh" ];
  };

  # 3. Open the firewall port for noVNC
  networking.firewall.allowedTCPPorts = [ 6081 ];
}