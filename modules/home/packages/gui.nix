{ pkgs, ... }:

let
  obs-cuda = pkgs.obs-studio.override {
    cudaSupport = true;
  };
in
{
  home.packages = with pkgs; [
    ## Multimedia
    gimp
    media-downloader
    pavucontrol
    video-trimmer

    # OBS with CUDA support and plugins
    (wrapOBS.override { obs-studio = obs-cuda; } {
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