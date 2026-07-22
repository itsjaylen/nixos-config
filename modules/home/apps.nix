# modules/home/apps.nix
{ pkgs, ... }:

{
  # Git
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Jaylen";
      };
    };
  };

  # Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # OBS Studio
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-vkcapture
      obs-pipewire-audio-capture
    ];
  };
}