{ pkgs, ... }:

let
  # Override websockify to skip its failing tests (jwcrypto key length bug)
  websockifyNoCheck = pkgs.python3Packages.websockify.overridePythonAttrs (oldAttrs: {
    doCheck = false;
    doInstallCheck = false;
    dontUsePytestCheck = true;
  });
in
{
  environment.systemPackages = with pkgs; [
    obs-studio
    xvfb
    x11vnc
    novnc
    websockifyNoCheck
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

  # 2. noVNC service: Convert VNC to WebSocket
  systemd.services.obs-novnc = {
    description = "noVNC websocket proxy for OBS";
    after = [ "obs-vnc.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${websockifyNoCheck}/bin/websockify --web ${pkgs.novnc}/share/webapps/novnc 6080 localhost:5900";
      Restart = "always";
    };
  };

  # Open firewall ports
  networking.firewall.allowedTCPPorts = [ 6080 ];
}