{ pkgs, ... }:

{
  virtualisation.docker.enable = true;

  virtualisation.oci-containers = {
    backend = "podman";
    containers.obs = {
      image = "ghcr.io/dilllxd/obs-distroav:intel";
      
      ports = [ "6081:6081" "4455:4455" ];
      
      extraOptions = [
        "--device=/dev/dri:/dev/dri"
        "--ulimit" "nofile=65536:65536"
      ];
      
      volumes = [
        "/var/lib/obs-config:/root/.config/obs-studio"
      ];
      
      
      
      environment = {
        RESOLUTION = "1920x1080";
        QT_QPA_PLATFORM = "xcb";
        QT_QPA_PLATFORMTHEME = "";
        QT_AUTO_SCREEN_SCALE_FACTOR = "0";
        QT_SCALE_FACTOR = "1";
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