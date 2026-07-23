# modules/system/niri.nix
{ config, lib, pkgs, ... }:

{
  options.mySystem.niri.enable = lib.mkEnableOption "Niri Wayland Desktop Environment with Noctalia Shell, Dolphin, and KDE portal integration";

  config = lib.mkIf config.mySystem.niri.enable {
    # Enable Wayland & Niri core support
    programs.niri.enable = true;

    # XDG Portals: Use KDE portal as primary for proper native file pickers
    xdg.portal = {
      enable = true;
      extraPortals = [ 
        pkgs.kdePackages.xdg-desktop-portal-kde
  pkgs.xdg-desktop-portal-gtk
      ];
      xdgOpenUsePortal = true;
    };

    # System packages required for your Niri layout, shell, and KDE integration
    environment.systemPackages = with pkgs; [
      # Window Management & Shell components
      niri
      fuzzel
      swaylock
      waybar
      mako
      awww
      noctalia-qs

      # Audio, Brightness & Media Utilities
      wireplumber
      playerctl
      brightnessctl
      libnotify

      # File Manager, Settings, & KDE Integration Tools
      kdePackages.dolphin
      kdePackages.dolphin-plugins
      kdePackages.kio-extras
      kdePackages.ffmpegthumbs
      kdePackages.kdeconnect-kde
      kdePackages.ark
      kdePackages.systemsettings # Essential for properly managing themes, icons, and fonts outside Plasma
      kdePackages.plasma-integration

      # Theming Engines
      kdePackages.qtstyleplugin-kvantum
      libsForQt5.qtstyleplugin-kvantum
      adwaita-qt
      adwaita-qt6
      nwg-look
      
      # GTK fallback themes
      gnome-themes-extra
      adwaita-icon-theme
    ];

    # Critical Environment Variables (injected systemd-wide so portals and apps inherit them correctly)
    environment.sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      QT_QPA_PLATFORMTHEME = "kde";
      QT_QPA_PLATFORMTHEME_QT6 = "kde";
      XDG_MENU_PREFIX = "plasma-"; # Fixes Dolphin default application and file association loss
      GTK_THEME = "Adwaita-dark";
    };
  };
}