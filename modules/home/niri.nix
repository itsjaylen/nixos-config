# modules/home/niri.nix
{ config, lib, pkgs, ... }:

{
  # Automatically link your repo file to ~/.config/niri/config.kdl
  home.file.".config/niri/config.kdl".source = ../../files/config.kdl;

  # If you want to drop user-specific packages only when Niri is used:
  home.packages = with pkgs; [
    fuzzel
    swaylock
    waybar
    mako
    awww
  ];
}