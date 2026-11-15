{ pkgs, inputs, lib, ... }:

let
  lutris-unwrapped = pkgs.lutris-unwrapped.overrideAttrs (oldAttrs: {
    postPatch = (oldAttrs.postPatch or "") + ''
      substituteInPlace lutris/util/display.py \
        --replace-fail 'if LIB_GNOME_DESKTOP_AVAILABLE:' \
                       'if LIB_GNOME_DESKTOP_AVAILABLE and hasattr(GnomeDesktop, "RRScreen"):'
    '';
  });

  lutris = pkgs.lutris.override { inherit lutris-unwrapped; };
in
{
  programs.lutris = {
    enable = true;
    package = lutris;

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
    flatpak # TODO MOVE LATER WITH SOBER

    ## Support Tools
    mangohud
    protonup-qt
    inputs.amethyst-mod-manager.packages.${pkgs.system}.default
  ];
}