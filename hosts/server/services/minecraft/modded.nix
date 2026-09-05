{ pkgs, ... }:

{
  services.minecraft-servers.servers.neoforge = {
    enable = true;
    package = pkgs.neoforgeServers.neoforge-26_2;
    # Force Java 21 instead of the system default
    java.package = pkgs.jdk21; 
    jvmOpts = "-Xms2G -Xmx2G";
    serverProperties = {
      server-port = 25566;
      motd = "Modded";
    };
  };
}