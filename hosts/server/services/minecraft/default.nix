{ config, pkgs, lib, ... }:

{
  services.minecraft-servers = {
    enable = true;
    eula = true;

    servers.minecraft = {
      enable = true;

      package = pkgs.minecraftServers.vanilla-26_2;

      memory = {
        min = "2G";
        max = "2G";
      };

      serverProperties = {
        server-port = 25565;
        motd = "Jaylen's Minecraft Server";
        online-mode = true;
        enable-command-block = true;
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 25565 ];
}
