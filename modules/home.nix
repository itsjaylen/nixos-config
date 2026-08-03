{ inputs, ... }:

{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    ./home/terminal.nix
    ./home/yazi.nix
    ./home/apps.nix
    ./home/packages.nix
    ./home/neovim.nix
    ./home/niri.nix
    ./home/noctalia.nix
    ./home/fastfetch.nix
    ./home/theme.nix
    ./home/notification.nix
  ];

  home.username = "jaylen";
  home.homeDirectory = "/home/jaylen";
  home.stateVersion = "26.05";


  programs.home-manager.enable = true;
}