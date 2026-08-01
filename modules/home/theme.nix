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
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
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

  ## --- Qt Configuration ---
  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style = {
      name = "fusion";
    };
  };

  ## --- Required Packages ---
  home.packages = with pkgs; [
    gnome-themes-extra
    glib
    dconf
  ];
}