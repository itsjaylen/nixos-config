{ config, pkgs, lib, ... }:

{
  imports = [
    ./vanilla.nix
    ./modded.nix
  ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true; # Automatically opens required ports;
  };

}