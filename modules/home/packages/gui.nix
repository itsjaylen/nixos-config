{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ## Multimedia
    gimp
    media-downloader
    pavucontrol
    video-trimmer

    # OBS with CUDA support and plugins inline
    (pkgs.wrapOBS {
      obs-studio = pkgs.obs-studio.override { cudaSupport = true; };
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-pipewire-audio-capture
        obs-vkcapture
      ];
    })

    ## Office
    libreoffice

    ## Utility
    dconf-editor
    popsicle
    mission-center # GUI resources monitor
    zenity
    zed-editor
  ];
}