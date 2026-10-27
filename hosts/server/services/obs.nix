{ pkgs, ... }:

{
  # You use podman as the backend, so docker isn't needed
  virtualisation.podman.enable = true;

  virtualisation.oci-containers = {
    backend = "podman";
    containers.obs = {
      image = "ghcr.io/dilllxd/obs-distroav:intel";

      ports = [ "6081:6081" "4455:4455" ];

      extraOptions = [
        "--device=/dev/dri:/dev/dri"
        "--ulimit" "nofile=65536:65536"
        "--shm-size=1g"   # Qt/Chromium-style apps misbehave with the default 64MB /dev/shm
      ];

      volumes = [
        "/var/lib/obs-config:/root/.config/obs-studio"
      ];

      environment = {
        RESOLUTION = "1920x1080";
        QT_QPA_PLATFORM = "xcb";
        QT_X11_NO_MITSHM = "1";
        QT_XCB_GL_INTEGRATION = "none";  # stops Qt popups using GL, which VNC can't capture
        QT_QUICK_BACKEND = "software";
      };

      cmd = [
        "bash" "-c"
        ''
          sed -i 's/^obs &/obs --disable-shutdown-check \&/' /start.sh
          exec /start.sh
        ''
      ];
    };
  };

  networking.firewall.allowedTCPPorts = [ 6081 4455 ];
}