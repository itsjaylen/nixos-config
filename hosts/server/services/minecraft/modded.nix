{ pkgs, ... }:

{
  services.minecraft-servers = {
    enable = true;
    eula = true; # <-- Must be defined here globally

    servers.modded = {
      enable = true; 
      package = pkgs.neoforgeServers.neoforge;
      jvmOpts = "-Xms4G -Xmx4G";

      serverProperties = {
        server-port = 25566;
        motd = "Modded Chaos";
      };
    };
  };
}