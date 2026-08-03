{ config, pkgs, ... }:

let
  # Custom package to install your local font from the files/ directory
  papyrusNerdFont = pkgs.stdenv.mkDerivation {
    name = "papyrus-nerd-font";
    src = ../../files/fonts;
    installPhase = ''
      mkdir -p $out/share/fonts/truetype
      cp *.ttf $out/share/fonts/truetype/
    '';
  };
in
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

    font = {
      name = "Papyrus Nerd Font 10";
      package = papyrusNerdFont;
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
    platformTheme.name = "qt6ct";
    style = {
      name = "kvantum";
    };
  };

  # Deploys KvGlass from your centralized 'files/' directory
  xdg.configFile."Kvantum/KvGlass".source = ../../files/Kvantum/KvGlass;

  # Instructs Kvantum to use KvGlass by default on startup
  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=KvGlass
  '';

  # Forces qt6ct to use Papirus icons, Kvantum style, and Papyrus Nerd Font by default
  xdg.configFile."qt6ct/qt6ct.conf".text = ''
    [Appearance]
    icon_theme=Papirus
    style=kvantum
    standard_dialogs=default
    
    [Fonts]
    fixed="Papyrus Nerd Font,10,-1,5,50,0,0,0,0,0"
    general="Papyrus Nerd Font,10,-1,5,50,0,0,0,0,0"
  '';

  ## --- Required System & Theme Packages ---
  home.packages = with pkgs; [
    gnome-themes-extra
    kdePackages.qtstyleplugin-kvantum
    qt6Packages.qt6ct
    papirus-icon-theme
    papyrusNerdFont
    glib
    dconf
  ];
}