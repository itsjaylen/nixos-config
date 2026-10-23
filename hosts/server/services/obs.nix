{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    obs-studio
    xvfb
    x11vnc
    novnc
  ];

  # 1. VNC service: Expose the virtual display :20 to localhost
  systemd.services.obs-vnc = {
    description = "x11vnc for OBS virtual display";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.x11vnc}/bin/x11vnc -display :20 -forever -shared -rfbport 5900 -localhost";
      Restart = "always";
    };
  };

  # 2. noVNC service: Use novnc_proxy instead of calling websockify directly
  systemd.services.obs-novnc = {
    description = "noVNC proxy for OBS";
    after = [ "obs-vnc.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.novnc}/bin/novnc_proxy --vnc localhost:5900 --listen 6080";
      Restart = "always";
    };
  };

  networking.firewall.allowedTCPPorts = [ 6080 ];
}