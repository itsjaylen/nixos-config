{ pkgs, ... }:

let
  obs-cuda = pkgs.obs-studio.override {
    cudaSupport = true;
  };
in
{
  # Configure OBS natively via Home Manager
  programs.obs-studio = {
    enable = true;
    package = obs-cuda;
    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
      obs-vkcapture
      obs-vaapi # Hardware acceleration & PipeWire capture support
    ];
  };

  home.packages = with pkgs; [
    ## Multimedia
    media-downloader
    pavucontrol
    video-trimmer
    gpu-screen-recorder-gtk

    ## Office
    libreoffice

    ## Utility
    dconf-editor
    popsicle
    mission-center # GUI resources monitor
    zenity
    zed-editor
    satty
  ];
}
