{ pkgs, ... }:

{
  # 1. Enable Docker (NixOS will use Podman backend if configured elsewhere,
  #    but this ensures the service exists)
  virtualisation.docker.enable = true;

  # 2. Declare the OBS container with the Safe Mode fix
  virtualisation.oci-containers = {
    backend = "podman"; # Your system already runs Kaneo under Podman
    containers.obs = {
      image = "ghcr.io/dilllxd/obs-distroav:intel";
      
      # Port mapping: noVNC web interface + OBS WebSocket
      ports = [ "6081:6081" "4455:4455" ];
      
      # Pass through the Intel GPU and cap file descriptors
      # (the ulimit fix prevents the x11vnc "endless connecting" hang)
      extraOptions = [
        "--device=/dev/dri:/dev/dri"
        "--ulimit" "nofile=65536:65536"
      ];
      
      # Persistence: save OBS configuration to the host
      volumes = [
        "/var/lib/obs-config:/root/.config/obs-studio"
      ];
      
      environment = {
        RESOLUTION = "1920x1080";
         QT_QPA_PLATFORM = "xcb";
      };
      
      # Patch /start.sh to add --disable-shutdown-check before running OBS.
      # This skips the "Safe Mode" dialog that blocks the main window.
      cmd = [
        "bash" "-c"
        ''
          sed -i 's/^obs &/obs --disable-shutdown-check \&/' /start.sh
          exec /start.sh
        ''
      ];
    };
  };

  # 3. Open firewall ports
  networking.firewall.allowedTCPPorts = [ 6081 4455 ];
}