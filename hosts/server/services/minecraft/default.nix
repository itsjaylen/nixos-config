{ config, pkgs, lib, ... }:

{
  imports = [
    ./vanilla.nix
    ./modded
  ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
  };

  # Automatically open firewall ports
  networking.firewall.allowedTCPPorts = [ 25565 25566 25567 8100 ];

  # Systemd override for the neoforge minecraft server
  systemd.services."minecraft-neoforge" = {
    serviceConfig = {
      Restart = "always";
      RestartSec = "10s"; # Waits 10 seconds before attempting a restart after a crash
    };
  };
}