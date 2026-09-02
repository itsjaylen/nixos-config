{ pkgs, lib, ... }:

{
  # Enable Niri compositor module
  programs.niri.enable = true;

  # Ensure XWayland compatibility layer runs cleanly under Wayland
  programs.xwayland.enable = true;

  # Hardware acceleration and Wayland environment configuration
  environment.sessionVariables = {
    # Force Electron / Chromium apps to run natively on Wayland
    NIXOS_OZONE_WL = "1";

    # Render using Wayland backends for GTK/QT
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    GDK_BACKEND = "wayland,x11,*";

    # Set default file picker / portal handler preference
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_TYPE = "wayland";
  };

  # Essential packages for desktop environment execution
  environment.systemPackages = with pkgs; [
    # X11 bridge for modern Wayland compositors
    xwayland-satellite

    # File manager and KDE portal backend integrations
    kdePackages.dolphin
    kdePackages.kio
    kdePackages.kio-extras

    # Desktop integration utilities
    libnotify
    wl-clipboard
  ];

  # D-Bus configuration
    services.dbus = {
      implementation = "broker";
      packages = [ pkgs.nautilus ];
    };
  
    # XDG Desktop Portals configuration (using Hyprland's portal for Niri to avoid wlr's first-frame bug)
    xdg = {
      mime.enable = true;
      portal = {
        enable = true;
        xdgOpenUsePortal = true;
        extraPortals = lib.mkForce [
          pkgs.xdg-desktop-portal-hyprland
          pkgs.xdg-desktop-portal-gtk
        ];
        config = {
          niri = lib.mkForce {
            default = [ "hyprland" "gtk" ];
            "org.freedesktop.impl.portal.ScreenCast" = [ "hyprland" ];
            "org.freedesktop.impl.portal.Screenshot" = [ "hyprland" ];
          };
        };
      };
    };

  # Enable D-Bus service for system communication and portals
  services.dbus.enable = true;
}
