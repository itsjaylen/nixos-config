{ pkgs, ... }:

{
  # KDE / Qt-native utilities
  home.packages = with pkgs.kdePackages; [
    okular        # Universal document viewer (PDFs, EPUBs, images)
    ark           # Archiving & compression tool (zip, tar, 7z)
    kate          # Feature-rich text editor (or use 'kwrite' for lightweight editing)
    gwenview      # Image viewer
  ];

  # Configure Kate / KWrite default settings via KDE config files
  xdg.configFile."katerc".text = ''
    [General]
    Show Line Numbers=true
    
    [Kate Document]
    Tab Width=4
    Replace Tabs=true
    
    [Kate View Space]
    Highlight Current Line=true
  '';

  qt = {
      enable = true;
      platformTheme.name = "gtk3";
      style.name = "adwaita-dark";
    };
}