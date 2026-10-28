{ pkgs, ... }:

let
  obsStart = pkgs.writeShellScript "obs-start.sh" ''
    sed -i 's/^obs &/obs --disable-shutdown-check --disable-gpu-compositing \&/' /start.sh
    exec /start.sh
  '';
in
{
  # Intel GPU (VAAPI/QSV) on the host
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ intel-media-driver vpl-gpu-rt ];
  };

  virtualisation.oci-containers = {
    backend = "podman";
    containers.obs = {
      image = "ghcr.io/dilllxd/obs-distroav:intel"; # pin a digest once it works
      autoStart = true;

      # Bind to localhost; reach it via SSH tunnel / Tailscale / reverse proxy
      ports = [
        "127.0.0.1:6081:6081"
        "127.0.0.1:4455:4455"
      ];

      extraOptions = [
        "--device=/dev/dri:/dev/dri"
        "--group-add=keep-groups"
        "--shm-size=1g"
        "--ulimit=nofile=65536:65536"
      ];

      volumes = [
        "/var/lib/obs-config:/root/.config/obs-studio"
        "${obsStart}:/obs-start.sh:ro"
      ];

      environment = {
        RESOLUTION = "1920x1080";
        # Dropdown/popup fixes for Qt under VNC
        QT_XCB_NO_XI2 = "1";
        QT_X11_NO_MITSHM = "1";
        QT_QPA_PLATFORM = "xcb";
        QT_AUTO_SCREEN_SCALE_FACTOR = "0";
      };

      entrypoint = "/bin/bash";
      cmd = [ "/obs-start.sh" ];
    };
  };

  systemd.tmpfiles.rules = [ "d /var/lib/obs-config 0750 root root -" ];

  # Only open to a trusted interface instead of globally
  networking.firewall.interfaces."tailscale0".allowedTCPPorts = [ 6081 4455 ];
}