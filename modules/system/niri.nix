# modules/system/niri.nix
{ config, lib, pkgs, ... }:

{
  options.mySystem.niri.enable = lib.mkEnableOption "Niri Wayland Desktop Environment with Noctalia Shell, Dolphin, and theme support";

  config = lib.mkIf config.mySystem.niri.enable {
    # Enable Wayland & Niri core support
    programs.niri.enable = true;

    # Enable XDG desktop portals required for file pickers (Dolphin / GTK / Qt apps)
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
      swww

      # Audio, Brightness & Media Utilities (tied to your keybinds)
      wireplumber
      playerctl
      brightnessctl
      libnotify

      # File Manager & Thumbnailers (Ensures Dolphin works fully with previews)
      kdePackages.dolphin
      kdePackages.kio-extras
      kdePackages.ffmpegthumbs
      kdePackages.kdeconnect-kde

      # Theming & Engines (Kvantum, GTK engines, qt5ct/qt6ct)
      kdePackages.qtstyleplugin-kvantum
      libsForQt5.qtstyleplugin-kvantum
      adwaita-qt
      adwaita-qt6
      nwg-look

      # Clipboard & Utilities
      cliphist
      wl-clipboard
    ];

    # Ensure Qt applications respect themes out of the box
    environment.sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qt5ct";
    };
  };
}