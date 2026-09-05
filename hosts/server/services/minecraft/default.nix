{ config, pkgs, lib, ... }:

{
  imports = [
    ./vanilla.nix
    ./modded.nix
  ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
  };

  networking.firewall.allowedTCPPorts = [ 25565 25566 25567 ];
}