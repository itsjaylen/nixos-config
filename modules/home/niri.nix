{ config, lib, pkgs, ... }:

{
  # Automatically link your repo file to ~/.config/niri/config.kdl
  home.file.".config/niri/config.kdl".source = ../../files/config.kdl;
  home.file.".config/niri/scripts/uploader.sh".source = ../../files/scripts/uploader.sh;

  # If you want to drop user-specific packages only when Niri is used:
  home.packages = with pkgs; [
    swaylock
    mako
    awww
  ];
}