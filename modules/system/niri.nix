# modules/system/niri.nix
{ config, lib, pkgs, ... }:

{
  options.mySystem.niri.enable = lib.mkEnableOption "Niri Wayland Desktop Environment with Noctalia Shell, Dolphin, and theme support";

  config = lib.mkIf config.mySystem.niri.enable {
    # Enable Wayland & Niri core support
    programs.niri.enable = true;

    # Enable XDG desktop portals required for file pickers and dark theme preferences
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gnome pkgs.xdg-desktop-portal-gtk ];
      xdgOpenUsePortal = true;
    };

    # System packages required for your Niri layout, shell, and utilities
    environment.systemPackages = with pkgs; [
      # Window Management & Shell components
      niri
      fuzzel
      swaylock
      waybar
      mako
      awww
      noctalia-qs

      # Audio, Brightness & Media Utilities (tied to your keybinds)
      wireplumber
      playerctl
      brightnessctl
      libnotify

      # File Manager, Context Menus, & Thumbnailers
      kdePackages.dolphin
      kdePackages.kio-extras
      kdePackages.ffmpegthumbs
      kdePackages.kdeconnect-kde
      kdePackages.ark        # Essential for right-click extract/compress actions in Dolphin
      kdePackages.filelight  # Disk usage visualization often used in context tools

      # Theming & Engines (Kvantum, GTK engines, qt5ct/qt6ct)
      kdePackages.qtstyleplugin-kvantum
      libsForQt5.qtstyleplugin-kvantum
      adwaita-qt
      adwaita-qt6
      nwg-look
      
      # Force dark theme GTK/Adwaita support
      gnome-themes-extra
      adwaita-icon-theme
    ];

    # Environment variables forcing dark mode and proper theme engines everywhere
    environment.sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qt5ct";
      GTK_THEME = "Adwaita-dark";
      # Tells apps and portals to prefer dark color scheme globally
      COLORTERM = "truecolor";
    };
  };
}