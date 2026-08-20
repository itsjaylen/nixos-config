{ pkgs, ... }:

{
  imports = [
    ./aliases.nix
    ./functions.nix
    ./plugins.nix
    ./fish.nix
  ];
}