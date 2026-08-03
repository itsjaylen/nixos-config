# modules/home/terminal/default.nix
{ ... }:

{
  imports = [
    ./kitty.nix
    ./fish.nix
    ./ssh.nix
    ./helix.nix
  ];
}