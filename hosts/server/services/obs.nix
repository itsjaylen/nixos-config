{ pkgs, ... }:

let
  # Patch websockify to replace the invalid test key (jwcrypto 1.5.7 regression)
  # This is the official upstream fix, also used by Gentoo
  websockifyPatch = pkgs.fetchpatch {
    url = "https://github.com/novnc/websockify/commit/f1e281d2c446380a0a8af7575a92b23ad65c6d4d.patch";
    sha256 = "sha256-l+j+baTDSEXhOajUKxaT21ET1iEnpiBHwysYnTt3ghk="; # replace with real hash on first build
  };
in
{
  # Apply the patch globally across all Python package sets
  nixpkgs.overlays = [
    (final: prev: {
      pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
        (python-final: python-prev: {
          websockify = python-prev.websockify.overridePythonAttrs (oldAttrs: {
            patches = (oldAttrs.patches or []) ++ [ websockifyPatch ];
          });
        })
      ];
    })
  ];

  environment.systemPackages = with pkgs; [
    obs-studio
    xvfb
    x11vnc
    novnc
  ];

  # 1. Create the virtual display :20
  systemd.services.xvfb-obs = {
    description = "Xvfb virtual display for OBS";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.xorg.xvfb}/bin/Xvfb :20 -screen 0 1920x1080x24";
      Restart = "always";
    };
  };

  # 2. Start x11vnc on display :20
  systemd.services.obs-vnc = {
    description = "x11vnc for OBS virtual display";
    after = [ "xvfb-obs.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.x11vnc}/bin/x11vnc -display :20 -forever -shared -rfbport 5900 -localhost";
      Restart = "always";
    };
  };

  # 3. Start noVNC proxy (calling websockify directly with the patched package)
  systemd.services.obs-novnc = {
    description = "noVNC proxy for OBS";
    after = [ "obs-vnc.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.python3Packages.websockify}/bin/websockify --web ${pkgs.novnc}/share/webapps/novnc 6080 localhost:5900";
      Restart = "always";
    };
  };

  networking.firewall.allowedTCPPorts = [ 6080 ];
}