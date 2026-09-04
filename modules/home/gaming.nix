{ pkgs, ... }:

{
  programs.lutris = {
    enable = true;

    extraPackages = with pkgs; [
      winetricks
      p7zip
    ];

    winePackages = with pkgs; [
      wineWow64Packages.staging
    ];
  };

  home.packages = with pkgs; [
    ## Minecraft
    (prismlauncher.override {
      # Custom Java runtimes passed directly to Prism Launcher
      jdks = [
        temurin-bin-21 # Adoptium OpenJDK 21
        temurin-bin-17 # Adoptium OpenJDK 17
        temurin-bin-8  # Adoptium OpenJDK 8
      ];
    })
    lunar-client

    ## Support Tools
    mangohud
    protonup-qt
  ];
}