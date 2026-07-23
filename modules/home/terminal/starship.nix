# modules/home/terminal/starship.nix
{ ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  home.file.".config/starship.toml".source = ../../../files/starship.toml;
}