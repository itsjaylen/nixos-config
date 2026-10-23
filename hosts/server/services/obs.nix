{ pkgs, ... }:

let
  # Patch websockify to replace the invalid test key (jwcrypto 1.5.7 regression)
  # This is the official upstream fix, also used by Gentoo [citation:7]
  websockifyPatch = pkgs.fetchpatch {
    url = "https://github.com/novnc/websockify/commit/f1e281d2c446380a0a8af7575a92b23ad65c6d4d.patch";
    sha256 = "sha256-l+j+baTDSEXhOajUKxaT21ET1iEnpiBHwysYnTt3ghk="; # fake, fix on build
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
    # websockify comes transitively via novnc, no need to list it
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

  # 2. noVNC service: novnc_proxy uses the patched websockify internally
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