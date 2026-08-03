# modules/home/notification.nix
{ config, pkgs, ... }:

{
  services.mako = {
    enable = true;
    defaultTimeout = 5000;
    font = "JetBrainsMono Nerd Font 10";
    backgroundColor = "#1e1e2e";
    textColor = "#cdd6f4";
    borderColor = "#89b4fa";
    borderRadius = 8;
    borderSize = 2;
    padding = "15";
    layer = "overlay";
  };
}