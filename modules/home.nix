# modules/home.nix
{ ... }:

{
  imports = [
    ./home/terminal.nix
    ./home/yazi.nix
    ./home/apps.nix
    ./home/packages.nix
    ./home/neovim.nix
  ];

  home.username = "jaylen";
  home.homeDirectory = "/home/jaylen";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}