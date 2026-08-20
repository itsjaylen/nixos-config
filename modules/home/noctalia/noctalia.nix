{ config, pkgs, ... }:
{
  # Enable Noctalia via Home Manager module / package
  programs.noctalia.enable = true;

  # Link your exact JSON configuration directly to Noctalia's runtime path
  xdg.configFile."noctalia/settings.json".text = builtins.readFile ./settings.json;
}