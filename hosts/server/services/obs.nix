{ pkgs, ... }:

{
  # 1. Enable Docker (if not already enabled)
  virtualisation.docker.enable = true;

  # 2. Declare the OBS container using NixOS's native OCI container support
  virtualisation.oci-containers = {
    backend = "docker";
    containers.obs = {
      # Use the Intel-specific image from the project
      image = "ghcr.io/dilllxd/obs-distroav:intel";
      
      # Port mapping: noVNC web interface
      ports = [ "6081:6081" ];
      
      # Critical step: pass through the Intel GPU device node
      # /dev/dri allows the container to access your UHD 630 for hardware acceleration
      extraOptions = [
        "--device=/dev/dri:/dev/dri"
      ];
      
      # Persistence: save OBS configuration to the host machine, so it's not lost when the container is rebuilt
      volumes = [
        "/var/lib/obs-config:/root/.config/obs-studio"
      ];
      
      # Optional: set screen resolution (default is 1920x1080)
      environment = {
        RESOLUTION = "1920x1080";
        # VNC_PASSWORD = "your_password"; # Uncomment and set if you want a password
      };
    };
  };

  # 3. Open the firewall port for noVNC
  networking.firewall.allowedTCPPorts = [ 6081 ];
}