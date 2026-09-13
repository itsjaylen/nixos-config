{ pkgs, inputs, ... }:

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
      jdks = [
        temurin-bin-21
        temurin-bin-17
        temurin-bin-8 
      ];
    })
    lunar-client

    ## Support Tools
    mangohud
    protonup-qt
    inputs.amethyst-mod-manager.packages.${pkgs.system}.default
  ];
}