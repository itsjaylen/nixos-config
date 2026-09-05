{ pkgs, ... }:

{
  services.minecraft-servers.servers.paper = {
    enable = true;
    package = pkgs.neoforgeServers.neoforge;
    jvmOpts = "-Xms2G -Xmx2G";

    serverProperties = {
      server-port = 25566;
      motd = "Modded";
    };
  };
}