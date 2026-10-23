{ pkgs, ... }:

let
  # Patch websockify to replace the invalid test key (jwcrypto 1.5.7 key length validation)
  websockifyPatched = pkgs.python3Packages.websockify.overridePythonAttrs (oldAttrs: {
    patches = (oldAttrs.patches or []) ++ [
      (pkgs.fetchpatch {
        url = "https://github.com/novnc/websockify/commit/f1e281d2c446380a0a8af7575a92b23ad65c6d4d.patch";
        sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # fake hash, fix on build
      })
    ];
  });
in
{
  # Override the package globally so novnc and everything else uses the patched version
  nixpkgs.overlays = [
    (final: prev: {
      python3Packages = prev.python3Packages // {
        websockify = websockifyPatched;
      };
    })
  ];

  environment.systemPackages = with pkgs; [
    obs-studio
    xvfb
    x11vnc
    novnc
    # websockify is pulled in transitively via novnc, no need to list it
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

  # 2. noVNC service: novnc_proxy internally uses the patched websockify
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