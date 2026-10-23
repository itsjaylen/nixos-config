{ pkgs, ... }:

{
  # 1. Enable Docker (if not already enabled)
  virtualisation.docker.enable = true;

  # 2. Declare the OBS container using NixOS's native OCI container support
  virtualisation.oci-containers.containers.obs = {
    image = "ghcr.io/dilllxd/obs-distroav:intel";
    ports = [ "6081:6081" ];
    extraOptions = [ "--device=/dev/dri:/dev/dri" ];
    volumes = [ "/var/lib/obs-config:/root/.config/obs-studio" ];
    environment = { RESOLUTION = "1920x1080"; };
    
    # Try capping the fd limit before the entrypoint runs
    cmd = [ "bash" "-c" "ulimit -n 65536; exec /entrypoint.sh" ];
  };

  # 3. Open the firewall port for noVNC
  networking.firewall.allowedTCPPorts = [ 6081 ];
}