{ config, pkgs, lib, ... }:

{
  services.minecraft-servers = {
    enable = true;
    eula = true;

    servers.minecraft = {
      enable = true;

      # Use the package provided by nix-minecraft.
      package = pkgs.minecraftServers.vanilla;

      jvmOpts = "-Xms2G -Xmx2G";

      serverProperties = {
        server-port = 25565;
        motd = "Jaylen's Minecraft Server";
        online-mode = true;
        enable-command-block = true;
        view-distance = 10;
        simulation-distance = 10;
      };
    };
  };

  networking.firewall.allowedTCPPorts = [
    25565
  ];
}
