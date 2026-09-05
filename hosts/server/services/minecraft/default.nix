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

  # Automatically open firewall ports if defined, or manage them globally
  networking.firewall.allowedTCPPorts = [ 25565 25566 25567 ];
}