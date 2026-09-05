{ pkgs, ... }:

{
  services.minecraft-servers.servers.modded = {
    enable = true; 
    eula = true; # <-- Missing: Required for the server to run
    package = pkgs.neoforgeServers.neoforge;
    jvmOpts = "-Xms4G -Xmx4G";

    serverProperties = {
      server-port = 25566;
      motd = "Modded Chaos";
    };
  };
}