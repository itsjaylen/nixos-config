{ pkgs, ... }:

{
  services.minecraft-servers.servers.modded = {
    enable = true; 
    package = pkgs.neoforgeServers.neoforge.override {
      jre_headless = pkgs.temurin-bin-21;
    };
    jvmOpts = "-Xms4G -Xmx4G";

    serverProperties = {
      server-port = 25566;
      motd = "Modded Chaos";
    };
  };
}