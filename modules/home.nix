# modules/home.nix
{ config, lib, inputs, ... }:

{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    ./home/terminal.nix
    ./home/yazi.nix
    ./home/apps.nix
    ./home/packages.nix
    ./home/neovim.nix
  ] ++ lib.optional config.mySystem.niri.enable ./home/niri.nix;

  home.username = "jaylen";
  home.homeDirectory = "/home/jaylen";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}