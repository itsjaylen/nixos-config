# modules/home/terminal/starship.nix
{ ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  # Deploy your starship.toml directly via XDG config mapping
  xdg.configFile."starship.toml".source = ../../../files/starship.toml;
}