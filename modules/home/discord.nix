{ pkgs, ... }:

{
  home.packages = with pkgs; [
    legcord
    vesktop
  ];
}
