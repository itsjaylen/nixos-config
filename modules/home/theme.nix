{ config, pkgs, ... }:

{
  ## --- Global Dark Mode (Dconf / XDG Settings) ---
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  ## --- GTK Configuration ---
  gtk = {
    enable = true;
    
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };

    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  ## --- Qt & Kvantum Engine Configuration ---
  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style = {
      name = "kvantum";
    };
  };

  # Deploys KvGlass from your centralized 'files/' directory
  xdg.configFile."Kvantum/KvGlass".source = ../../files/Kvantum/KvGlass;

  # Instructs Kvantum to use KvGlass by default on startup.
  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=KvGlass
  '';

  ## --- Required System & Theme Packages ---
  home.packages = with pkgs; [
    gnome-themes-extra
    kdePackages.qtstyleplugin-kvantum
    papirus-icon-theme
    glib
    dconf
  ];
}