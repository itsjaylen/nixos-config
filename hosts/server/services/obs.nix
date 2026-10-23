{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
      obs-studio
      xvfb
      x11vnc
      novnc
      python3Packages.websockify # Correct path in current nixpkgs
  ];

  # 1. VNC service: Expose the virtual display :20 to localhost
  systemd.services.obs-vnc = {
    description = "x11vnc for OBS virtual display";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ]; # Or start manually
    serviceConfig = {
      ExecStart = "${pkgs.x11vnc}/bin/x11vnc -display :20 -forever -shared -rfbport 5900 -localhost";
      Restart = "always";
    };
  };

  # 2. noVNC service: Convert VNC to WebSocket
  systemd.services.obs-novnc = {
    description = "noVNC websocket proxy for OBS";
    after = [ "obs-vnc.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.python3Packages.websockify}/bin/websockify --web ${pkgs.novnc}/share/webapps/novnc 6080 localhost:5900";
      Restart = "always";
    };
  };

  # Open firewall ports (if needed)
  networking.firewall.allowedTCPPorts = [ 6080 ];
}