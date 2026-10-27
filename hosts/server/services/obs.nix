{ pkgs, ... }:

{
  # Only podman is used as the backend, so Docker isn't needed
  # virtualisation.docker.enable = true;

  virtualisation.podman.enable = true;

  virtualisation.oci-containers = {
    backend = "podman";
    containers.obs = {
      image = "ghcr.io/dilllxd/obs-distroav:intel";

      ports = [ "6081:6081" "4455:4455" ];

      extraOptions = [
        "--device=/dev/dri:/dev/dri"
        "--ulimit" "nofile=65536:65536"
        "--shm-size=2g"   # Qt/Chromium-style apps can render blank without enough shared memory
      ];

      volumes = [
        "/var/lib/obs-config:/root/.config/obs-studio"
      ];

      environment = {
        RESOLUTION = "1920x1080";
        QT_XCB_NO_XI2 = "1";

        # Qt popup/menu rendering fixes under VNC
        QT_X11_NO_MITSHM = "1";
        QT_XCB_GL_INTEGRATION = "none";
        QT_QUICK_BACKEND = "software";
        QT_QPA_PLATFORMTHEME = "";
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