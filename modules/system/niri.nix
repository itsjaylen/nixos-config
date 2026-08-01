# modules/system/niri.nix
{ config, lib, pkgs, inputs, ... }:

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

    # Register application desktop entry for Noctalia / Quickshell portal ID binding
    environment.etc."xdg/applications/dev.noctalia.noctalia-qs.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Noctalia Shell
      Exec=noctalia-shell
      StartupWMClass=dev.noctalia.noctalia-qs
      Categories=Utility;
    '';

    # System packages required for your Niri layout, shell, and KDE integration
    environment.systemPackages = with pkgs; [
      # Window Management & Shell components
      niri
      swaylock
      mako
      awww
      inputs.noctalia.packages.${stdenv.hostPlatform.system}.default

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
      kdePackages.systemsettings
      kdePackages.plasma-integration
      kdePackages.polkit-kde-agent-1

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

    # Critical Environment Variables
    # Critical Environment Variables
    environment.sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      XDG_MENU_PREFIX = "plasma-";
      GTK_THEME = "Adwaita-dark";
    };
  };
}