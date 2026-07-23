# modules/home/terminal/starship.nix
{ ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  # Correct Home Manager syntax for deploying a config file
  home.file.".config/starship.toml".source = ../../../files/starship.toml;
}